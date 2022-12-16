//
//  GameDetailViewController.swift
//  GameBook
//
//  Created by Hasan Uysal on 13.12.2022.
//

import UIKit
import MaterialActivityIndicator

class GameDetailViewController: BaseViewController {

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
    var id: Int?
    var favorite: Favorite?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.getGameDetail(id: id ?? 0)
        navigationBarSetup()
        indicator.startAnimating()
        favorite = viewModel.isGameFavorite(id: id ?? 0)
    }
    
    func rightBarButtonItemSetup(name: String){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: name), style: .plain, target: self, action: #selector(favoriteTapped))
    }
    
    func navigationBarSetup(){
        rightBarButtonItemSetup(name: "heart")
        setNavBarTitle(view: self, title: "Game Detail")
    }
    
    @objc func favoriteTapped(){
        if favorite != nil {
            CoreDataManager.shared.deleteFavoriteId(favorite: favorite!)
            rightBarButtonItemSetup(name: FavoriteButtonStyle.notFavorite.rawValue)
        } else {
            favorite = CoreDataManager.shared.saveFavoriteId(id: self.id ?? 0)
            rightBarButtonItemSetup(name: FavoriteButtonStyle.favorite.rawValue)
        }
        NotificationCenter.default.post(name: NSNotification.Name("favButtonNotification"), object: favorite)
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
        rightBarButtonItemSetup(name: viewModel.favoriteButtonImageName(id: self.id ?? 0))
        indicator.stopAnimating()
    }
    
    func gameFailed(error: Error) {
        showAlert(message: error.localizedDescription) {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func labelTextSetup(){
        nameLabel.text = viewModel.game?.name
        platformLabel.text = viewModel.getPlatformNames()
        descriptionLabel.text = viewModel.game?.description.trimHTMLTags()
        playtimeLabel.text = "AVERAGE PLAYTIME : " + String(viewModel.game?.playtime ?? 0)
        releaseLabel.text = viewModel.game?.released
        genresLabel.text = viewModel.getGameGenres()
        metascoreLabel.text = String(viewModel.game?.metacritic ?? 0)
    }
}

