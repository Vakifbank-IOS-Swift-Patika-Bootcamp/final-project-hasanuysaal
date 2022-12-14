//
//  FavoriteListViewController.swift
//  GameBook
//
//  Created by Hasan Uysal on 14.12.2022.
//

import UIKit

class FavoriteListViewController: BaseViewController {

    @IBOutlet weak var favoriteListTableView: UITableView!
    
    var viewModel: FavoriteListViewModelProtocol = FavoriteListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBarTitle(view: self, title: "Favorites")
        viewModel.delegate = self
        viewModel.getFavoriteGames()
        favoriteListTableView.delegate = self
        favoriteListTableView.dataSource = self
        favoriteListTableView.register(UINib(nibName: "FavoriteListTableViewCell", bundle: nil), forCellReuseIdentifier: "FavoriteListCell")
        NotificationCenter.default.addObserver(self, selector: #selector(favChanged), name: NSNotification.Name("favButtonNotification"), object: nil)
    }
    
    @objc func favChanged() {
        viewModel.getFavoriteGames()
    }

}

extension FavoriteListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, completionHandler) in
                guard let favoriteGame = CoreDataManager.shared.getFavoriteGame(id: self.viewModel.favoriteGames![indexPath.row].id) else {
                    return
                }
                CoreDataManager.shared.deleteFavoriteId(favorite: favoriteGame)
                self.viewModel.getFavoriteGames()
            completionHandler(true)
        }
        let updateAction = UIContextualAction(style: .normal, title: "Update") { (action, sourceView, completionHandler) in
            print("upadate clicked")
                //segue to update view
            completionHandler(true)
        }
            return UISwipeActionsConfiguration(actions: [deleteAction, updateAction])
        }
    
}

extension FavoriteListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let gameCount = viewModel.getFavoriteGameCount() else {
            return 0
        }
        return gameCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = favoriteListTableView.dequeueReusableCell(withIdentifier: "FavoriteListCell", for: indexPath) as? FavoriteListTableViewCell, let gameModel = viewModel.getFavoriteGame(index: indexPath.row) else {
            return UITableViewCell()
        }
        cell.configure(game: gameModel)
        return cell
        
        
    }
}

extension FavoriteListViewController: FavoriteListViewModelDelegate {
    func gameLoaded() {
        favoriteListTableView.reloadData()
    }
    
    func gameFailed(error: Error) {
        //
    }
}
