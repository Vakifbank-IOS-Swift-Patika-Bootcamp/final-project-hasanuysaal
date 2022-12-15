//
//  NoteListViewModel.swift
//  GameBook
//
//  Created by Hasan Uysal on 15.12.2022.
//

import Foundation

protocol NoteListViewModelProtocol{
    var delegate: NoteListViewModelDelegate? { get set }
    var notes: [NoteModel]? { get set }
    func getNotes()
    func getNotesCount() -> Int
    func deleteNote(note: NoteModel)
    
}

protocol NoteListViewModelDelegate: AnyObject {
    func notesLoaded()
    func notesFailed(error: Error)
}

class NoteListViewModel: NoteListViewModelProtocol {
    var delegate: NoteListViewModelDelegate?
    
    var notes: [NoteModel]?
    
    func getNotes() {
        
    }
    func getNotesCount() -> Int {
        1
    }
    func deleteNote(note: NoteModel) {
        
    }
    
}
