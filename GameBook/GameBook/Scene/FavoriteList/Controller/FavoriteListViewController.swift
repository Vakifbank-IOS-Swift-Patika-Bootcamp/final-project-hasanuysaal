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
    }

}

extension FavoriteListViewController: FavoriteListViewModelDelegate {
    func gameLoaded() {
        print(viewModel.favoriteGames)
    }
    
    func gameFailed(error: Error) {
        //
    }
    
    
}
