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
    
    
    func configure(){
        noteImage.image = UIImage(named: "star")
        gameName.text = "GTA5"
        noteText.text = "gta5gta5gta5gta5gta5gta5gta5gta5gta5gta5gta5gta5gta5gta5gta5"
    }
}
