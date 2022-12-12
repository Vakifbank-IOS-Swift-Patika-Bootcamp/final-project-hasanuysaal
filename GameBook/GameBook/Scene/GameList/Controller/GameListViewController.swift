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
        viewModel.fetchGames(pageNum: viewModel.pageCounter)
        collectionViewSetup()
    }

    func collectionViewSetup(){
        gameListCollectionView.dataSource = self
    }
    
    func scrollToTopOfCollectionView(){
        let topOffest = CGPoint(x: 0, y: -(gameListCollectionView.contentInset.top))
        gameListCollectionView.setContentOffset(topOffest, animated: true)
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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == "UICollectionElementKindSectionFooter"{
            guard let footer = gameListCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "GameCellFooter", for: indexPath) as? GameCellFooterView else {
                return UICollectionReusableView()
            }
            if viewModel.pageCounter == 1 {
                footer.previousButton.isHidden = true
            } else {
                footer.previousButton.isHidden = false
            }
            footer.delegate = self
            return footer
        }
        return UICollectionReusableView()
    }
}

extension GameListViewController: GameCellFooterViewDelegate {
    func nextButton() {
        scrollToTopOfCollectionView()
        viewModel.pageCounter += 1
        viewModel.fetchGames(pageNum: viewModel.pageCounter)
        
    }
    func previousButton() {
        scrollToTopOfCollectionView()
        viewModel.pageCounter -= 1
        viewModel.fetchGames(pageNum: viewModel.pageCounter)
    }
}
