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
    
    var starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 120, y: 15, width: 55, height: 30)
        imageView.image = UIImage(named: "star")
        return imageView
    }()
    
    var ratingLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 138, y: 20, width: 50, height: 20)
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
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
        ratingLabel.text = model.rating.clean
        subviewsSetup()
    }
    
    func subviewsSetup(){
        self.addSubview(ratingLabel)
        imageView.addSubview(starImageView)
    }
}
