//
//  FavoriteListTableViewCell.swift
//  GameBook
//
//  Created by Hasan Uysal on 14.12.2022.
//

import UIKit
import SDWebImage

final class FavoriteListTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var gameImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var releaseLabel: UILabel!
    @IBOutlet private weak var genresLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    
    private var genresArr: [String] = []

    func configure(game: GameDetailModel){
        gameImageView.sd_setImage(with: URL(string: game.imageUrl), placeholderImage: UIImage(named: "gta"))
        gameImageView.layer.cornerRadius = 25
        nameLabel.text = game.name
        releaseLabel.text = game.released
        genresLabel.text = game.genres.genresToString
        ratingLabel.text = String(game.rating)
    }
}
