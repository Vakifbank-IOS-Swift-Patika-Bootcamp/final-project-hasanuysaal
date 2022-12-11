//
//  GameListCollectionViewCell.swift
//  GameBook
//
//  Created by Hasan Uysal on 11.12.2022.
//

import UIKit

class GameListCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    
    var genresArr: [String] = []
    
    var genres: String {
        get{
            return genresArr.joined(separator: " ,")
        }
    }
    
    func configure(model: GameModel){
        imageView.image = UIImage(named: "gta")
        nameLabel.text = model.name
        releaseDateLabel.text = model.released
        genresArr = model.genres.map { $0.name }
        genresLabel.text = genres
    }
}
