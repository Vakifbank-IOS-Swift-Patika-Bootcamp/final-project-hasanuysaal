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
        tableViewSetup()
        NotificationCenter.default.addObserver(self, selector: #selector(favChanged), name: NSNotification.Name("favButtonNotification"), object: nil)
    }
    
    func tableViewSetup(){
        favoriteListTableView.delegate = self
        favoriteListTableView.dataSource = self
        tableViewRegister()
    }
    
    func tableViewRegister(){
        favoriteListTableView.register(UINib(nibName: "FavoriteListTableViewCell", bundle: nil), forCellReuseIdentifier: "FavoriteListCell")
    }
    
    func gameNotFoundAlertShow(){
        DispatchQueue.main.async {
            if self.viewModel.getIdsFromDB().isEmpty {
                self.showAlert(message: FavoriteGameListError.gameNotFound.localizedDescription) {
                    self.tabBarController?.selectedIndex = 0
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        gameNotFoundAlertShow()
    }
    
    @objc func favChanged() {
        viewModel.getFavoriteGames()
    }

}

extension FavoriteListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, completionHandler) in
            self.viewModel.deleteFavoriteGameFromDB(index: indexPath.row)
            self.viewModel.getFavoriteGames()
            completionHandler(true)
            self.gameNotFoundAlertShow()
            
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
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
        showAlert(message: error.localizedDescription) {
            self.tabBarController?.selectedIndex = 0
        }
    }
}
