//
//  GameDetailViewModel.swift
//  GameBook
//
//  Created by Hasan Uysal on 13.12.2022.
//

import Foundation

protocol GameDetailViewModelProtocol{
    var delegate: GameDetailViewModelDelegate? { get set }
    var game: GameDetailModel? { get }
    var gameImagesUrl: [String?] { get set }
    var platforms: [String]? { get set }
    func getGameDetail(id: Int)
    func getGameImageCount() -> Int?
    func getPlatformNames() -> String?
    func getGameGenres() -> String?
}

protocol GameDetailViewModelDelegate: AnyObject{
    func gameLoaded()
    func gameFailed()
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
        let genresArr = game?.genres.map { $0.name }
        let genres = genresArr?.joined(separator: ", ")
        return genres
    }
    
}
