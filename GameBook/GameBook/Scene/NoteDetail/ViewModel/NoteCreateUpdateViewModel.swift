//
//  NoteCreateUpdateViewModel.swift
//  GameBook
//
//  Created by Hasan Uysal on 15.12.2022.
//

import Foundation
import UIKit

protocol NoteCreateUpdateViewModelProtocol {
    var delegate: NoteCreateUpdateViewModelDelegate? { get set }
    var validationdelegate: NoteValidationDelegate? { get set }
    func createNote(image: Data, gameName: String, noteText: String)
    func updateNote(note: Note, image: Data, gameName: String, noteText: String)
    func validateNote(isUpdate: Bool, image: Data?, gameName: String?, noteText: String?, note: Note?)
    func isUpdateNote(note: Note?) -> Bool
    func setForms(note: Note, imageView: UIImageView, gameName: UITextField, noteText: UITextView)
}

protocol NoteCreateUpdateViewModelDelegate: AnyObject {
    func noteSuccess()
    func noteFailed(error: String)
}

protocol NoteValidationDelegate: AnyObject {
    func noteValid()
    func noteNotValid(error: String)
}

class NoteCreateUpdateViewModel: NoteCreateUpdateViewModelProtocol {
    
    var validationdelegate: NoteValidationDelegate?
    var delegate: NoteCreateUpdateViewModelDelegate?
    
    func createNote(image: Data, gameName: String, noteText: String) {
        if CoreDataManager.shared.saveNote(image: image, gameName: gameName, noteText: noteText) != nil {
            delegate?.noteSuccess()
        } else {
            delegate?.noteFailed(error: NSLocalizedString("An error occurred while creating the note!", comment: ""))
        }
    }
    
    func updateNote(note: Note, image: Data, gameName: String, noteText: String) {
        if CoreDataManager.shared.updateNote(image: image, gameName: gameName, noteText: noteText, note: note) != nil {
            delegate?.noteSuccess()
        } else {
            delegate?.noteFailed(error: NSLocalizedString("An error occurred while updating the note!", comment: ""))
        }
    }
    
    func validateNote(isUpdate: Bool, image: Data?, gameName: String?, noteText: String?, note: Note?) {
        guard let validatedImage = image else {
            validationdelegate?.noteNotValid(error: NSLocalizedString("You should pick an image before saving note!", comment: ""))
            return
        }
        guard let validatedGameName = gameName else {
            validationdelegate?.noteNotValid(error: NSLocalizedString("You should enter game name before saving note!", comment: ""))
            return
        }
        guard let validatedNoteText = noteText else {
            validationdelegate?.noteNotValid(error: NSLocalizedString("You should enter note before saving note!", comment: ""))
            return
        }
        if validatedGameName == "" {
            validationdelegate?.noteNotValid(error: NSLocalizedString("You should enter game name before saving note!", comment: ""))
            return
        }
        if validatedNoteText == "" {
            validationdelegate?.noteNotValid(error: NSLocalizedString("You should enter note before saving note!", comment: ""))
            return
        }
        if isUpdate {
            updateNote(note: note!, image: validatedImage, gameName: validatedGameName, noteText: validatedNoteText)
        } else {
            createNote(image: validatedImage, gameName: validatedGameName, noteText: validatedNoteText)
        }
        validationdelegate?.noteValid()
    }
    
    func setForms(note: Note, imageView: UIImageView, gameName: UITextField, noteText: UITextView){
        imageView.image = UIImage(data: note.image!)
        gameName.text = note.gameName
        noteText.text = note.noteText
    }
    
    func isUpdateNote(note: Note?) -> Bool {
        if note != nil {
            return true
        } else {
            return false
        }
    }
}
