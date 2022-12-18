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
    private var gameNamePickerView = UIPickerView()
    
    var viewModel: NoteCreateUpdateViewModelProtocol = NoteCreateUpdateViewModel()
    var note: Note?
    private var games: [SearchedGameModel]?
    private var pickerPlaceHolder = NSLocalizedString("Type and click search button.", comment: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerViewDelegateSetup()
        setScreenAppearance()
        viewModelDelagateSetup()
        gameNameTextField.delegate = self
        imageViewSetup()
        addGestureRecognizerToView()
        notificationCenterSetup()
    }
    
    private func notificationCenterSetup() {
        NotificationCenter.default.addObserver(self, selector: #selector(searchGameName), name: NSNotification.Name("gameNameSearchTapped"), object: nil)
    }
    
    private func viewModelDelagateSetup() {
        viewModel.validationdelegate = self
        viewModel.noteGameNameDelegate = self
    }
    
    private func setScreenAppearance() {
        if viewModel.isUpdateNote(note: note) {
            viewModel.setForms(note: note!, imageView: noteImageView, gameName: gameNameTextField, noteText: noteTextView)
            noteButton.setTitle(NSLocalizedString("Update", comment: ""), for: .normal)
        } else {
            noteButton.setTitle(NSLocalizedString("Create", comment: ""), for: .normal)
            setImageViewPlaceHolder()
        }
    }
    
    
    @objc private func searchGameName() {
        gameNameTextField.inputView = gameNamePickerView
        view.endEditing(true)
        pickerPlaceHolder = NSLocalizedString("Searching...", comment: "")
        gameNamePickerView.reloadAllComponents()
        guard let text = gameNameTextField.text else {
            return
        }
        games = viewModel.getGameName(name: text)
    }
    
    private func pickerViewDelegateSetup() {
        gameNamePickerView.delegate = self
        gameNamePickerView.dataSource = self
    }
    
    private func addGestureRecognizerToView(){
        let gR = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        view.addGestureRecognizer(gR)
    }
    
    @objc private func closeKeyboard(){
        view.endEditing(true)
    }
    
    private func imageViewSetup() {
        noteImageView.isUserInteractionEnabled = true
        addGestureRecognizerToImage()
    }
    
    private func setImageViewPlaceHolder(){
        noteImageView.image = UIImage(systemName: "plus.viewfinder")
        noteImageView.tintColor = .systemRed
    }
    
    private func addGestureRecognizerToImage() {
        let gR = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        noteImageView.addGestureRecognizer(gR)
    }
    
    @objc private func imageViewTapped() {
        let pickerController = createImagePicker()
        present(pickerController, animated: true, completion: nil)
    }
    
    private func createImagePicker() -> UIImagePickerController {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        pickerController.sourceType = .photoLibrary
        return pickerController
    }
    
    @IBAction private func noteButtonPressed(_ sender: Any) {
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
    
    func noteNotValid(error: Error) {
        showAlert(message: error.localizedDescription) {}
    }
}

extension NoteCreateUpdateViewController: NoteGameNameDelegate {
    func gameLoaded() {
        gameNamePickerView.reloadAllComponents()
    }
    
    func gameFailed() {
        pickerPlaceHolder = NSLocalizedString("Game not found.", comment: "")
    }
}

extension NoteCreateUpdateViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        games?.count ?? 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        games?[row].name ?? pickerPlaceHolder
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        gameNameTextField.text = games?[row].name ?? ""
        gameNameTextField.resignFirstResponder()
        
    }
}

extension NoteCreateUpdateViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {

    }
}


