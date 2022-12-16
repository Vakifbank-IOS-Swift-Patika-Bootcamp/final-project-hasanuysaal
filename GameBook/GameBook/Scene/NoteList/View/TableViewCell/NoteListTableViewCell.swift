//
//  NoteListTableViewCell.swift
//  GameBook
//
//  Created by Hasan Uysal on 15.12.2022.
//

import UIKit

class NoteListTableViewCell: UITableViewCell {

    @IBOutlet weak var noteImage: UIImageView!
    @IBOutlet weak var gameName: UILabel!
    @IBOutlet weak var noteText: UILabel!
    
    
    func configure(noteModel: Note){
        gameName.text = noteModel.gameName
        noteText.text = noteModel.noteText
        imageViewSetup(image : noteModel.image!)
        
    }
    
    func imageViewSetup(image: Data){
        noteImage.layer.cornerRadius = 25
        guard let image = UIImage(data: image) else {
            noteImage.image = UIImage(named: "star")
            return
        }
        
        noteImage.image = image
    }
}
