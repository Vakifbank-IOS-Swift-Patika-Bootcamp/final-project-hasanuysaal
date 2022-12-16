//
//  NoteListTableViewCell.swift
//  GameBook
//
//  Created by Hasan Uysal on 15.12.2022.
//

import UIKit

final class NoteListTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var noteImage: UIImageView!
    @IBOutlet private weak var gameName: UILabel!
    @IBOutlet private weak var noteText: UILabel!
    
    func configure(noteModel: Note){
        gameName.text = noteModel.gameName
        noteText.text = noteModel.noteText
        imageViewSetup(image: noteModel.image!)
    }
    
    func imageViewSetup(image: Data){
        noteImage.layer.cornerRadius = 25
        guard let image = UIImage(data: image) else {
            return
        }
        noteImage.image = image
    }
}
