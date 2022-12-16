//
//  NoteCreateUpdateViewController.swift
//  GameBook
//
//  Created by Hasan Uysal on 15.12.2022.
//

import UIKit

final class NoteCreateUpdateViewController: BaseViewController {
    
    @IBOutlet private weak var noteImageView: UIImageView!
    @IBOutlet private weak var gameNameTextField: CustomTextField!
    @IBOutlet private weak var noteTextView: CustomTextView!
    @IBOutlet private weak var noteButton: UIButton!
    
    var viewModel: NoteCreateUpdateViewModelProtocol = NoteCreateUpdateViewModel()
    var note: Note?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if viewModel.isUpdateNote(note: note) {
            viewModel.setForms(note: note!, imageView: noteImageView, gameName: gameNameTextField, noteText: noteTextView)
            noteButton.setTitle(NSLocalizedString("Update", comment: ""), for: .normal)
        } else {
            noteButton.setTitle(NSLocalizedString("Create", comment: ""), for: .normal)
        }
        
        viewModel.validationdelegate = self
        imageViewSetup()
    }
    
    func imageViewSetup() {
        noteImageView.image = UIImage(systemName: "plus.viewfinder")
        noteImageView.tintColor = .systemRed
        noteImageView.isUserInteractionEnabled = true
        addGestureRecognizerToImage()
    }
    
    func addGestureRecognizerToImage() {
        let gR = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        noteImageView.addGestureRecognizer(gR)
    }
    
    @objc func imageViewTapped() {
        let pickerController = createImagePicker()
        present(pickerController, animated: true, completion: nil)
    }
    
    func createImagePicker() -> UIImagePickerController {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        pickerController.sourceType = .photoLibrary
        return pickerController
    }
    
    @IBAction func noteButtonPressed(_ sender: Any) {
        let imageData = noteImageView.image?.jpegData(compressionQuality: 0.5)
        viewModel.validateNote(isUpdate: viewModel.isUpdateNote(note: note), image: imageData, gameName: gameNameTextField.text, noteText: noteTextView.text, note: note)
    }
}

extension NoteCreateUpdateViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            return
        }
        noteImageView.image = image
        dismiss(animated: true)
    }
}

extension NoteCreateUpdateViewController: NoteValidationDelegate {
    func noteValid() {
        dismiss(animated: true)
    }
    
    func noteNotValid(error: String) {
        showAlert(message: error) {}
    }
}



