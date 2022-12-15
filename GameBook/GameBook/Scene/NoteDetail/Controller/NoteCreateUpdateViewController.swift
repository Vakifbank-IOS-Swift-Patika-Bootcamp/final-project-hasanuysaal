//
//  NoteCreateUpdateViewController.swift
//  GameBook
//
//  Created by Hasan Uysal on 15.12.2022.
//

import UIKit

class NoteCreateUpdateViewController: BaseViewController {
    
    @IBOutlet weak var noteImageView: UIImageView!
    @IBOutlet weak var gameNameTextField: CustomTextField!
    @IBOutlet weak var noteTextView: CustomTextView!
    @IBOutlet weak var noteButton: UIButton!
    
    var viewModel: NoteCreateUpdateViewModelProtocol = NoteCreateUpdateViewModel()
    var note: Note?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
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
        print("imageViewTapped")
    }
    
    @IBAction func noteButtonPressed(_ sender: Any) {
    }
}

extension NoteCreateUpdateViewController: NoteCreateUpdateViewModelDelegate {
    func noteSuccess() {
        
    }
    
    func noteFailed() {
        
    }
}
