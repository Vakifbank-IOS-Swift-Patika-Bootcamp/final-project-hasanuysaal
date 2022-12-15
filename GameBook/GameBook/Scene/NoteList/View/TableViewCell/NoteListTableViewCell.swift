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
        noteImage.image = UIImage(named: "star")
        gameName.text = noteModel.gameName
        noteText.text = noteModel.noteText
    }
}
