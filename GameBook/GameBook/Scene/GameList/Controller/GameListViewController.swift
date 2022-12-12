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
        searchBarSetup()
    }
    
    func searchBarSetup(){
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        navigationItem.searchController = search
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes([.foregroundColor : UIColor.systemRed], for: .normal)
    }

    func collectionViewSetup(){
        gameListCollectionView.dataSource = self
    }
    
    func scrollToTopOfCollectionView(){
        let topOffest = CGPoint(x: 0, y: -(gameListCollectionView.contentInset.top))
        gameListCollectionView.setContentOffset(topOffest, animated: true)
    }
    
    @IBAction func filterButtonPressed(_ sender: Any) {
        let filterView = GameListFilterView(frame: CGRect(origin: CGPoint(x: 16, y: 30), size: CGSize(width: view.center.x, height: 100)))
        filterView.delegate = self
        filterView.alpha = 0
        UIView.animate(withDuration: 1.0) {
            filterView.alpha = 1
        }
        view.addSubview(filterView)
    }
    
    @IBAction func sortButtonPressed(_ sender: Any) {
        viewModel.sortGames()
        gameListCollectionView.reloadData()
    }
    
}

extension GameListViewController: GameListViewModelDelegate {
    func gamesLoaded() {
        viewModel.searchedGames = viewModel.games
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
        if viewModel.isSortButton {
            viewModel.pageCounter += 1
            viewModel.getGamesRatingSorted(pageNum: viewModel.pageCounter)
        } else {
            viewModel.pageCounter += 1
            viewModel.fetchGames(pageNum: viewModel.pageCounter)
        }
    }
    
    func previousButton() {
        scrollToTopOfCollectionView()
        if viewModel.isSortButton {
            viewModel.pageCounter -= 1
            viewModel.getGamesRatingSorted(pageNum: viewModel.pageCounter)
        } else {
            viewModel.pageCounter -= 1
            viewModel.fetchGames(pageNum: viewModel.pageCounter)
        }
    }
}

extension GameListViewController: GameListFilterViewDelegate {
    func getPopularGames() {
        scrollToTopOfCollectionView()
        viewModel.getPopularGames()
    }
    
    func getUpcomingGames() {
        scrollToTopOfCollectionView()
        viewModel.getUpcomeGames()
    }
}

extension GameListViewController: UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        viewModel.games = viewModel.searchedGames?.filter( { $0.name.lowercased().contains(text.lowercased()) })
        if text == "" {
            viewModel.games = viewModel.searchedGames
        }
        gameListCollectionView.reloadData()
    }
    
}
