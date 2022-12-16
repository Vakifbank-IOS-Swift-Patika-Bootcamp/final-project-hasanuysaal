//
//  GameDetailViewModel.swift
//  GameBook
//
//  Created by Hasan Uysal on 13.12.2022.
//

import Foundation
import UIKit

enum FavoriteButtonStyle: String {
    case favorite = "heart.fill"
    case notFavorite = "heart"
}

protocol GameDetailViewModelProtocol{
    var delegate: GameDetailViewModelDelegate? { get set }
    var game: GameDetailModel? { get }
    var gameImagesUrl: [String?] { get set }
    var platforms: [String]? { get set }
    func getGameDetail(id: Int)
    func getGameImageCount() -> Int?
    func getPlatformNames() -> String?
    func getGameGenres() -> String?
    func isGameFavorite(id: Int) -> Favorite?
    func favoriteButtonImageName(id: Int) -> String
}

protocol GameDetailViewModelDelegate: AnyObject{
    func gameLoaded()
    func gameFailed(error: Error)
}

class GameDetailViewModel: GameDetailViewModelProtocol {
    
    weak var delegate: GameDetailViewModelDelegate?
    var game: GameDetailModel?
    var gameImagesUrl: [String?] = []
    var platforms: [String]?
    
    func getGameDetail(id: Int) {
        GameDBClient.getGameDetail(id: id) { [weak self] gameDetail, error in
            guard let self = self else {
                return
            }
            if let error = error {
                self.delegate?.gameFailed(error: error)
                return
            }
            self.game = gameDetail
            self.gameImagesUrl.append(gameDetail?.imageUrl)
            self.gameImagesUrl.append(gameDetail?.additionalImageUrl)
            self.platforms = gameDetail?.parentPlatforms.map{ $0.platform.name }
            self.delegate?.gameLoaded()
        }
    }
    
    func getPlatformNames() -> String? {
        platforms?.joined(separator: ", ")
    }
    
    func getGameImageCount() -> Int? {
        gameImagesUrl.count
    }
    
    func getGameGenres() -> String? {
        return game?.genres.genresToString
    }
    
    func isGameFavorite(id: Int) -> Favorite? {
        let game = CoreDataManager.shared.getFavoriteGame(id: id)
        if game != nil {
            return game
        } else {
            return nil
        }
    }
    
    func favoriteButtonImageName(id: Int) -> String {
        if isGameFavorite(id: id) != nil {
            return FavoriteButtonStyle.favorite.rawValue
        } else {
            return FavoriteButtonStyle.notFavorite.rawValue
        }
    }
}
