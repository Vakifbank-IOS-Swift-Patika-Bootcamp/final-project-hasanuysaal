//
//  GameListViewController.swift
//  GameBook
//
//  Created by Hasan Uysal on 11.12.2022.
//

import UIKit

class GameListViewController: UIViewController {

    var viewModel: GameListViewModelProtocol = GameListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        print(viewModel.fetchGames())
    }

}

extension GameListViewController: GameListViewModelDelegate {
    func gamesLoaded() {
        print(viewModel.getGame(at: 1))
    }
    
    func gamesFailed() {
        print("failed")
    }
    
    
}
