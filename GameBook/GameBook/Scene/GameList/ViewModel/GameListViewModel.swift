//
//  GameListViewModel.swift
//  GameBook
//
//  Created by Hasan Uysal on 11.12.2022.
//

import Foundation

protocol GameListViewModelProtocol{
    var pageCounter: Int { get set }
    var isSortButton: Bool { get set }
    var games: [GameModel]? { get set }
    var searchedGames: [GameModel]? { get set }
    var delegate: GameListViewModelDelegate? { get set }
    func fetchGames(pageNum: Int)
    func getGame(at index: Int) -> GameModel?
    func getGameId(at index: Int) -> Int
    func getGamesCount() -> Int
    func getGamesRatingSorted(pageNum: Int)
    func getPopularGames()
    func getUpcomeGames()
    func sortGames()
}

protocol GameListViewModelDelegate: AnyObject{
    func gamesLoaded()
    func gamesFailed()
}

class GameListViewModel: GameListViewModelProtocol{
    
    weak var delegate: GameListViewModelDelegate?
    
    var games: [GameModel]?
    var searchedGames: [GameModel]?
    var pageCounter = 1
    var isSortButton: Bool = false
    
    func fetchGames(pageNum: Int) {
        GameDBClient.getGamesResponse(pageNum: pageNum) { [weak self] gameResponse, error in
            guard let self = self else {
                return
            }
            self.games = gameResponse?.results
            self.delegate?.gamesLoaded()
        }
    }
    
    func sortGames(){
        let sorted = self.games?.sorted(by: { $0.rating > $1.rating })
        self.games = sorted
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
    
    func getGamesRatingSorted(pageNum: Int) {
        GameDBClient.getGamesRatingSortedResponse(pageNum: pageNum) { [weak self] gameResponse, error in
            guard let self = self else {
                return
            }
            self.games = gameResponse?.results
            self.delegate?.gamesLoaded()
        }
    }
    
    func getPopularGames() {
        GameDBClient.getPopularGamesResponse { [weak self] gameResponse, error in
            guard let self = self else {
                return
            }
            self.games = gameResponse?.results
            self.delegate?.gamesLoaded()
        }
    }
    
    func getUpcomeGames() {
        GameDBClient.getUpcomeGamesResponse { [weak self] gameResponse, error in
            guard let self = self else {
                return
            }
            self.games = gameResponse?.results
            self.delegate?.gamesLoaded()
        }
    }
    
    
    
}
