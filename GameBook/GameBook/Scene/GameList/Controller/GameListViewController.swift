//
//  GameListViewController.swift
//  GameBook
//
//  Created by Hasan Uysal on 11.12.2022.
//

import UIKit

class GameListViewController: BaseViewController {

    @IBOutlet weak var gameListCollectionView: UICollectionView!
    
    var viewModel: GameListViewModelProtocol = GameListViewModel()
    let search = UISearchController(searchResultsController: nil)
    var filterView = GameListFilterView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.fetchGames(pageNum: viewModel.pageCounter)
        filterViewSetup()
        collectionViewSetup()
        searchBarSetup()
        indicator.startAnimating()
    }
    
    func filterViewSetup(){
        filterView = GameListFilterView(frame: CGRect(origin: CGPoint(x: 16, y: 30), size: CGSize(width: view.center.x - 16, height: 100)))
        filterView.delegate = self
    }
    
    func searchBarSetup(){
        search.searchResultsUpdater = self
        navigationItem.searchController = search
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes([.foregroundColor : UIColor.systemRed], for: .normal)
    }

    func collectionViewSetup(){
        gameListCollectionView.dataSource = self
        gameListCollectionView.delegate = self
    }
    
    func scrollToTopOfCollectionView(){
        let topOffest = CGPoint(x: 0, y: -(gameListCollectionView.contentInset.top))
        gameListCollectionView.setContentOffset(topOffest, animated: true)
    }
    
    @IBAction func filterButtonPressed(_ sender: Any) {
        if !viewModel.isFilterShow {
            filterView.alpha = 0
            UIView.animate(withDuration: 1.0) {
                self.filterView.alpha = 1
            }
            view.addSubview(filterView)
        } else {
            filterView.removeFromSuperview()
        }
        viewModel.isFilterShow.toggle()
    }
    
    @IBAction func sortButtonPressed(_ sender: Any) {
        viewModel.sortGames()
        gameListCollectionView.reloadData()
        filterView.removeFromSuperview()
    }
    
}

extension GameListViewController: GameListViewModelDelegate {
    func gamesLoaded() {
        viewModel.searchedGames = viewModel.games
        search.searchBar.text = ""
        indicator.stopAnimating()
        gameListCollectionView.reloadData()
    }
    
    func gamesFailed(error: Error) {
        showAlert(message: error.localizedDescription) { }
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

extension GameListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toGameDetailVC", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toGameDetailVC" {
            guard let indexPath = sender as? IndexPath else {
                return
            }
            let destinationVC = segue.destination as! GameDetailViewController
            destinationVC.id = viewModel.getGameId(at: indexPath.row)
        }
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
        filterView.removeFromSuperview()
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
