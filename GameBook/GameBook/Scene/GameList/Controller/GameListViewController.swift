//
//  GameListViewController.swift
//  GameBook
//
//  Created by Hasan Uysal on 11.12.2022.
//

import UIKit

class GameListViewController: UIViewController {

    @IBOutlet weak var gameListCollectionView: UICollectionView!
    
    var viewModel: GameListViewModelProtocol = GameListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.fetchGames()
        collectionViewSetup()
    }

    func collectionViewSetup(){
        gameListCollectionView.dataSource = self
    }
    
}

extension GameListViewController: GameListViewModelDelegate {
    func gamesLoaded() {
        gameListCollectionView.reloadData()
    }
    
    func gamesFailed() {
        print("failed")
    }
    
    
}

extension GameListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.getGamesCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = gameListCollectionView.dequeueReusableCell(withReuseIdentifier: "GameCell", for: indexPath) as? GameListCollectionViewCell, let gameModel = viewModel.getGame(at: indexPath.row) else {
            return UICollectionViewCell()
        }
        cell.configure(model: gameModel)
        return cell
    }
    
    
}
