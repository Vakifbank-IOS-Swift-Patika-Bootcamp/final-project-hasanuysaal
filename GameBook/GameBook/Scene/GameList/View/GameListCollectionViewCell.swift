//
//  GameListCollectionViewCell.swift
//  GameBook
//
//  Created by Hasan Uysal on 11.12.2022.
//

import UIKit
import SDWebImage

class GameListCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    
    var starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 127, y: 15, width: 35, height: 35)
        imageView.image = UIImage(named: "star")
        return imageView
    }()
    
    var ratingLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 140, y: 28, width: 50, height: 20)
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        return label
    }()
    
    var genresArr: [String] = []
    
    var genres: String {
        get{
            return genresArr.joined(separator: " ,")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderWidth = 1.5
        layer.borderColor = UIColor.systemRed.cgColor
        layer.cornerRadius = 20.0
        imageView.layer.cornerRadius = 25.0
        
    }
    
    func configure(model: GameModel){
        imageView.sd_setImage(with: URL(string: model.image), placeholderImage: UIImage(named: "gta"))
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
