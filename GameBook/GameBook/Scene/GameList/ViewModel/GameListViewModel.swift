//
//  GameListViewModel.swift
//  GameBook
//
//  Created by Hasan Uysal on 11.12.2022.
//

import Foundation

protocol GameListViewModelProtocol{
    var pageCounter: Int { get set }
    var delegate: GameListViewModelDelegate? { get set }
    func fetchGames(pageNum: Int)
    func getGame(at index: Int) -> GameModel?
    func getGameId(at index: Int) -> Int
    func getGamesCount() -> Int
}

protocol GameListViewModelDelegate: AnyObject{
    func gamesLoaded()
    func gamesFailed()
}

class GameListViewModel: GameListViewModelProtocol{
    
    weak var delegate: GameListViewModelDelegate?
    
    var games: [GameModel]?
    var pageCounter = 1
    
    func fetchGames(pageNum: Int) {
        GameDBClient.getGamesResponse(pageNum: pageNum) { gameResponse, error in
            self.games = gameResponse?.results
            self.delegate?.gamesLoaded()
        }
    }
    
    func getGame(at index: Int) -> GameModel? {
        games?[index]
    }
    
    func getGameId(at index: Int) -> Int {
        games?[index].id ?? 0
    }
    
    func getGamesCount() -> Int {
        games?.count ?? 0
    }
    
    
}
