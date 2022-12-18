//
//  GameListViewModel.swift
//  GameBook
//
//  Created by Hasan Uysal on 11.12.2022.
//

import UIKit

protocol GameListViewModelProtocol{
    var pageCounter: Int { get set }
    var isSortButton: Bool { get set }
    var isFilterShow: Bool { get set }
    var games: [GameModel]? { get set }
    var searchedGames: [GameModel]? { get set }
    var delegate: GameListViewModelDelegate? { get set }
    var localNotificationManager: LocalNotificationManagerProtocol { get set }
    func fetchGames(pageNum: Int)
    func getGame(at index: Int) -> GameModel?
    func getGameId(at index: Int) -> Int?
    func getGamesCount() -> Int
    func getGamesRatingSorted(pageNum: Int)
    func getPopularGames()
    func getUpcomeGames()
    func sortGames()
    func changeLanguage()
    func getNextPageGame()
    func getPreviousPageGame()
    func getRightBarButtonImage() -> String
}

protocol GameListViewModelDelegate: AnyObject{
    func gamesLoaded()
    func gamesFailed(error: Error)
}

final class GameListViewModel: GameListViewModelProtocol{
    
    weak var delegate: GameListViewModelDelegate?
    var localNotificationManager: LocalNotificationManagerProtocol = LocalNotificationManager()
    
    var games: [GameModel]?
    var searchedGames: [GameModel]?
    var pageCounter = 1
    var isSortButton: Bool = false
    var isFilterShow: Bool = false
    
    func fetchGames(pageNum: Int) {
        GameDBClient.getGamesResponse(pageNum: pageNum) { [weak self] gameResponse, error in
            guard let self = self else {
                return
            }
            if let error = error {
                self.delegate?.gamesFailed(error: error)
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
    
    func getGameId(at index: Int) -> Int? {
        games?[index].id
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
    
    func getRightBarButtonImage() -> String {
        let languagePrefix = Locale.preferredLanguages[0].split(separator: "-").first
        
        if languagePrefix == "tr" {
            return "🇬🇧"
        } else {
            return "🇹🇷"
        }
    }
    
    func changeLanguage() {
        let languagePrefix = Locale.preferredLanguages[0].split(separator: "-").first
        
        if languagePrefix == "tr" {
            UserDefaults.standard.set(["en"], forKey: "AppleLanguages")
            UserDefaults.standard.synchronize()
            
            Bundle.setLanguage("en")
            
            exit(0)
        } else {
            UserDefaults.standard.set(["tr"], forKey: "AppleLanguages")
            UserDefaults.standard.synchronize()
            
            Bundle.setLanguage("tr")
            
            exit(0)
        }
    }
    
    func getNextPageGame() {
        if isSortButton {
            pageCounter += 1
            getGamesRatingSorted(pageNum: pageCounter)
        } else {
            pageCounter += 1
            fetchGames(pageNum: pageCounter)
        }
    }
    
    func getPreviousPageGame() {
        if isSortButton {
            pageCounter -= 1
            getGamesRatingSorted(pageNum: pageCounter)
        } else {
            pageCounter -= 1
            fetchGames(pageNum: pageCounter)
        }
    }
}
