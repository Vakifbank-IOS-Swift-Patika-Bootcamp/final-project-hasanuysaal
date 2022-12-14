//
//  FovoriteListViewModel.swift
//  GameBook
//
//  Created by Hasan Uysal on 14.12.2022.
//

import Foundation

protocol FavoriteListViewModelProtocol{
    var delegate: FavoriteListViewModelDelegate? { get set }
    var gameIds: [Int] { get }
    var favoriteGames: [GameDetailModel]? { get set }
    func getIdsFromDB()-> [Int]
    func getFavoriteGames()
    func getFavoriteGameCount() -> Int?
    func deleteFavoriteGameFromDB() -> Bool
}

protocol FavoriteListViewModelDelegate: AnyObject{
    func gameLoaded()
    func gameFailed(error: Error)
}

class FavoriteListViewModel: FavoriteListViewModelProtocol {
    
    var gameIds: [Int] = []
    var delegate: FavoriteListViewModelDelegate?
    var id: [Int]?
    var favoriteGames: [GameDetailModel]? = []
    let gruop = DispatchGroup()
    
    func getFavoriteGames(){
        self.gameIds = getIdsFromDB()
        for id in gameIds {
            self.gruop.enter()
            GameDBClient.getGameDetail(id: id) { [weak self] gameResponse, error in
                guard let self = self else {
                    return
                }
                
                if let error = error {
                    self.delegate?.gameFailed(error: error)
                    return
                }
                if let response = gameResponse {
                    self.favoriteGames?.append(response)
                    print(response)
                }
                self.gruop.leave()
                
            }
        }
        self.gruop.notify(queue: .main) {
            self.delegate?.gameLoaded()
        }
    }
    
    func getIdsFromDB() -> [Int] {
        [3498,10,15] // test data
    }
    
    func getFavoriteGameCount() -> Int? {
        0
    }
    
    func deleteFavoriteGameFromDB() -> Bool {
        true
    }
    
    
}
