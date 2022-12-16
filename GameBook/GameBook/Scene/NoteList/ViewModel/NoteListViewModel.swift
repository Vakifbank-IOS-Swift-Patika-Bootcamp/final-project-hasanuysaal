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
    func getNote(index: Int) -> Note?
    func getNotesCount() -> Int
    func deleteNote(index: Int)
}

protocol NoteListViewModelDelegate: AnyObject {
    func notesLoaded()
    func notesFailed(error: Error)
}

final class NoteListViewModel: NoteListViewModelProtocol {
    
    var delegate: NoteListViewModelDelegate?
    var notes: [Note]?
    
    func getNotes() {
        notes = CoreDataManager.shared.getNotes()
        delegate?.notesLoaded()
    }
    
    func getNote(index: Int) -> Note? {
        notes?[index]
    }
    
    func getNotesCount() -> Int {
        if notes != nil {
            return notes!.count
        } else {
            return 0
        }
    }
    
    func deleteNote(index: Int) {
        guard let note = notes?[index] else {
            return
        }
        CoreDataManager.shared.deleteNote(note: note)
    }
}
