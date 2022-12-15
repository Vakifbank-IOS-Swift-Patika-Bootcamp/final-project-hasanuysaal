//
//  NoteCreateUpdateViewModel.swift
//  GameBook
//
//  Created by Hasan Uysal on 15.12.2022.
//

import Foundation

protocol NoteCreateUpdateViewModelProtocol {
    var delegate: NoteCreateUpdateViewModelDelegate? { get set }
}

protocol NoteCreateUpdateViewModelDelegate: AnyObject {
    func noteSuccess()
    func noteFailed()
}

class NoteCreateUpdateViewModel: NoteCreateUpdateViewModelProtocol {
    
    var delegate: NoteCreateUpdateViewModelDelegate?
    
}
