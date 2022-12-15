//
//  NoteListViewModel.swift
//  GameBook
//
//  Created by Hasan Uysal on 15.12.2022.
//

import Foundation

protocol NoteListViewModelProtocol{
    var delegate: NoteListViewModelDelegate? { get set }
    var notes: [Note]? { get set }
    func getNotes()
    func getNotesCount() -> Int
    func deleteNote(note: Note)
    
}

protocol NoteListViewModelDelegate: AnyObject {
    func notesLoaded()
    func notesFailed(error: Error)
}

class NoteListViewModel: NoteListViewModelProtocol {
    var delegate: NoteListViewModelDelegate?
    
    var notes: [Note]?
    
    func getNotes() {
        notes = CoreDataManager.shared.getNotes()
        delegate?.notesLoaded()
    }
    func getNotesCount() -> Int {
        if notes != nil {
            return notes!.count
        } else {
            return 0
        }
    }
    
    func deleteNote(note: Note) {
        CoreDataManager.shared.deleteNote(note: note)
    }
    
}
