//
//  FavoriteListTableViewCell.swift
//  GameBook
//
//  Created by Hasan Uysal on 14.12.2022.
//

import UIKit
import SDWebImage

class FavoriteListTableViewCell: UITableViewCell {

    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    var genresArr: [String] = []
    
    var genres: String {
        get{
            return genresArr.joined(separator: " ,")
        }
    }
    
    func configure(game: GameDetailModel){
        gameImageView.sd_setImage(with: URL(string: game.imageUrl), placeholderImage: UIImage(named: "gta"))
        gameImageView.layer.cornerRadius = 25
        nameLabel.text = game.name
        releaseLabel.text = game.released
        genresArr = game.genres.map { $0.name }
        genresLabel.text = genres
        ratingLabel.text = String(game.rating)
    }
    
}
