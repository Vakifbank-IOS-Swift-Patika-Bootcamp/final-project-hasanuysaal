//
//  FovoriteListViewModel.swift
//  GameBook
//
//  Created by Hasan Uysal on 14.12.2022.
//

import Foundation

enum FavoriteGameListError: Error {
    case gameNotFound
    case unexpected(code: Int)
}

extension FavoriteGameListError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .gameNotFound:
            return NSLocalizedString(
                "There is no game on favorite list. You will be redirected to the home page.",
                comment: ""
            )
        case .unexpected(_):
            return NSLocalizedString(
                "An unexpected error occurred.",
                comment: ""
            )
        }
    }
}

protocol FavoriteListViewModelProtocol{
    var delegate: FavoriteListViewModelDelegate? { get set }
    var gameIds: [Int] { get }
    var favoriteGames: [GameDetailModel]? { get set }
    func getIdsFromDB()-> [Int]
    func getFavoriteGames()
    func getFavoriteGameCount() -> Int?
    func deleteFavoriteGameFromDB(index: Int)
    func getFavoriteGame(index: Int) -> GameDetailModel? 
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
    
    func getFavoriteGameCount() -> Int? {
        if favoriteGames?.count != 0 {
            return favoriteGames!.count
        } else {
            return nil
        }
    }
    
    func deleteFavoriteGameFromDB(index: Int) {
        guard let favoriteGame = CoreDataManager.shared.getFavoriteGame(id: favoriteGames![index].id) else {
            return
        }
        CoreDataManager.shared.deleteFavoriteId(favorite: favoriteGame)
    }
}
