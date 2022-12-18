//
//  GameDetailViewController.swift
//  GameBook
//
//  Created by Hasan Uysal on 13.12.2022.
//

import UIKit
import MaterialActivityIndicator

final class GameDetailViewController: BaseViewController {
    
    @IBOutlet private weak var playtimeLabel: UILabel!
    @IBOutlet private weak var platformLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var releaseLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var genresLabel: UILabel!
    @IBOutlet private weak var metascoreLabel: UILabel!
    @IBOutlet private weak var genresTitleLabel: UILabel!
    @IBOutlet private weak var metascoreTitleLabel: UILabel!
    
    @IBOutlet private weak var gameDetailCollectionView: UICollectionView! {
        didSet {
            gameDetailCollectionView.delegate = self
            gameDetailCollectionView.dataSource = self
        }
    }
    
    private var viewModel: GameDetailViewModelProtocol = GameDetailViewModel()
    var id: Int?
    var favorite: Favorite?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.getGameDetail(id: id)
        navigationBarSetup()
        indicator.startAnimating()
        favorite = viewModel.getFavoriteModel(id: id)
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
            favorite = nil
        } else {
            favorite = CoreDataManager.shared.saveFavoriteId(id: self.id)
            rightBarButtonItemSetup(name: FavoriteButtonStyle.favorite.rawValue)
        }
        NotificationCenter.default.post(name: NSNotification.Name("favButtonNotification"), object: favorite)
    }
    
    func labelTextSetup(){
        genresTitleLabel.text = NSLocalizedString("Genres", comment: "")
        metascoreTitleLabel.text = NSLocalizedString("Metascore", comment: "")
        nameLabel.text = viewModel.game?.name
        platformLabel.text = viewModel.getPlatformNames()
        descriptionLabel.text = viewModel.game?.description.trimHTMLTags()
        playtimeLabel.text = NSLocalizedString("AVERAGE PLAYTIME : ", comment: "") + String(viewModel.getGamePlaytime())
        releaseLabel.text = viewModel.game?.released
        genresLabel.text = viewModel.game?.genres.genresToString
        metascoreLabel.text = String(viewModel.getGameMetacritic())
    }
}

extension GameDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.getGameImageCount()
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
        rightBarButtonItemSetup(name: viewModel.favoriteButtonImageName(id: self.id))
        indicator.stopAnimating()
    }
    
    func gameFailed(error: Error) {
        showAlert(message: error.localizedDescription) {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
}
