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
    func getFavoriteGameCount() -> Int
    func deleteFavoriteGameFromDB(index: Int)
    func getFavoriteGame(index: Int) -> GameDetailModel? 
}

protocol FavoriteListViewModelDelegate: AnyObject{
    func gameLoaded()
    func gameFailed(error: Error)
}

final class FavoriteListViewModel: FavoriteListViewModelProtocol {
    
    var gameIds: [Int] = []
    var delegate: FavoriteListViewModelDelegate?
    var id: [Int]?
    var favoriteGames: [GameDetailModel]? = []
    private let gruop = DispatchGroup()
    
    func getFavoriteGames(){
        self.gameIds = getIdsFromDB()
        favoriteGames = []
        
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
                }
                self.gruop.leave()
            }
        }
        self.gruop.notify(queue: .main) {
            self.delegate?.gameLoaded()
        }
    }
    
    func getIdsFromDB() -> [Int] {
        CoreDataManager.shared.getFavoritesId()
    }
    
    func getFavoriteGame(index: Int) -> GameDetailModel? {
        if favoriteGames != nil {
            return favoriteGames![index]
        } else {
            return nil
        }
    }
    
    func getFavoriteGameCount() -> Int {
        if favoriteGames?.count != nil {
            return favoriteGames!.count
        } else {
            return 0
        }
    }
    
    func deleteFavoriteGameFromDB(index: Int) {
        guard let favoriteGame = CoreDataManager.shared.getFavoriteGame(id: favoriteGames![index].id) else {
            return
        }
        CoreDataManager.shared.deleteFavoriteId(favorite: favoriteGame)
    }
}
