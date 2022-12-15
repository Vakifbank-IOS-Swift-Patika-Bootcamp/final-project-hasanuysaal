//
//  NoteCreateUpdateViewModel.swift
//  GameBook
//
//  Created by Hasan Uysal on 15.12.2022.
//

import Foundation

protocol NoteCreateUpdateViewModelProtocol {
    var delegate: NoteCreateUpdateViewModelDelegate? { get set }
    func createNote(image: Data?, gameName: String, noteText: String)
}

protocol NoteCreateUpdateViewModelDelegate: AnyObject {
    func noteSuccess()
    func noteFailed()
}

class NoteCreateUpdateViewModel: NoteCreateUpdateViewModelProtocol {
    
    var delegate: NoteCreateUpdateViewModelDelegate?
    
    func createNote(image: Data?, gameName: String, noteText: String) {
        CoreDataManager.shared.saveNote(image: image, gameName: gameName, noteText: noteText)
        delegate?.noteSuccess()
    }
    
}
