//
//  NoteCreateUpdateViewModel.swift
//  GameBook
//
//  Created by Hasan Uysal on 15.12.2022.
//

import Foundation

protocol NoteCreateUpdateViewModelProtocol {
    var delegate: NoteCreateUpdateViewModelDelegate? { get set }
    var validationdelegate: NoteValidationDelegate? { get set }
    func createNote(image: Data, gameName: String, noteText: String)
    func validateNote(image: Data?, gameName: String?, noteText: String?)
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
        CoreDataManager.shared.saveNote(image: image, gameName: gameName, noteText: noteText)
        delegate?.noteSuccess()
    }
    
    func validateNote(image: Data?, gameName: String?, noteText: String?) {
        guard let validatedImage = image else {
            validationdelegate?.noteNotValid(error: "You should pick an image before saving note!")
            return
        }
        guard let validatedGameName = gameName else {
            validationdelegate?.noteNotValid(error: "You should enter game name before saving note!")
            return
        }
        guard let validatedNoteText = noteText else {
            validationdelegate?.noteNotValid(error: "You should enter note before saving note!")
            return
        }
        if validatedGameName == "" {
            validationdelegate?.noteNotValid(error: "You should enter game name before saving note!")
            return
        }
        if validatedNoteText == "" {
            validationdelegate?.noteNotValid(error: "You should enter note before saving note!")
            return
        }
        createNote(image: validatedImage, gameName: validatedGameName, noteText: validatedNoteText)
        validationdelegate?.noteValid()
    }
    
}
