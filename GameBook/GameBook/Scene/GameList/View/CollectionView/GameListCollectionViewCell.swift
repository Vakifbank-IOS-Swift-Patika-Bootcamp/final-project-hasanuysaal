//
//  GameListCollectionViewCell.swift
//  GameBook
//
//  Created by Hasan Uysal on 11.12.2022.
//

import UIKit
import SDWebImage

final class GameListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var genresLabel: UILabel!
    
    private var starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 127, y: 15, width: 35, height: 35)
        imageView.image = UIImage(named: "star")
        return imageView
    }()
    
    private var ratingLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 135, y: 15, width: 35, height: 35)
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layerSetup()
        subviewsSetup()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    func configure(model: GameModel){
        imageView.sd_setImage(with: URL(string: model.image), placeholderImage: UIImage(named: "gta"))
        nameLabel.text = model.name
        releaseDateLabel.text = model.released
        genresLabel.text = model.genres.genresToString
        ratingLabel.text = model.rating.clean
    }
    
    func layerSetup(){
        layer.borderWidth = 1.5
        layer.borderColor = UIColor.systemRed.cgColor
        layer.cornerRadius = 20.0
        imageView.layer.cornerRadius = 25.0
    }
    
    func subviewsSetup(){
        imageView.addSubview(starImageView)
        imageView.addSubview(ratingLabel)
    }
}
