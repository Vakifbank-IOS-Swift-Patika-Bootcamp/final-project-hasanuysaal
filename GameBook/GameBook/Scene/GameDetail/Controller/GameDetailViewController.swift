//
//  GameDetailViewController.swift
//  GameBook
//
//  Created by Hasan Uysal on 13.12.2022.
//

import UIKit

class GameDetailViewController: UIViewController {

    @IBOutlet weak var playtimeLabel: UILabel!
    @IBOutlet weak var platformLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var metascoreLabel: UILabel!
    
    @IBOutlet weak var gameDetailCollectionView: UICollectionView! {
        didSet {
            gameDetailCollectionView.delegate = self
            gameDetailCollectionView.dataSource = self
        }
    }
    
    var viewModel: GameDetailViewModelProtocol = GameDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        navigationBarSetup()
    }
    
    func navigationBarSetup(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(fovoriteTapped))
        navigationItem.title = "Game Detail"
    }
    
    @objc func fovoriteTapped(){
        print("fovoriteTapped")
    }

}

extension GameDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let imageCount = viewModel.getGameImageCount() else {
            return 0
        }
        return imageCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = gameDetailCollectionView.dequeueReusableCell(withReuseIdentifier: "GameDetailCell", for: indexPath) as? GameDetailCollectionViewCell, let imageUrl = viewModel.gameImagesUrl[indexPath.row] else {
            return UICollectionViewCell()
        }
        cell.configure(imageUrl: imageUrl)
        return cell
    }
}

extension GameDetailViewController: GameDetailViewModelDelegate {
    func gameLoaded() {
        labelTextSetup()
        gameDetailCollectionView.reloadData()
    }
    
    func gameFailed() {
        //
    }
    
    func labelTextSetup(){
        nameLabel.text = viewModel.game?.name
        platformLabel.text = viewModel.getPlatformNames()
        descriptionLabel.text = viewModel.game?.description.trimHTMLTags()
        playtimeLabel.text = "AVERAGE PLAYTIME : " + String(viewModel.game?.playtime ?? 0)
        releaseLabel.text = viewModel.game?.released
    }
}

