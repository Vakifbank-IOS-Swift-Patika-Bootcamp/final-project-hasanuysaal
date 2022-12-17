//
//  GameModel.swift
//  GameBook
//
//  Created by Hasan Uysal on 11.12.2022.
//

import Foundation

struct GameModel: Decodable, Equatable {
    
    static func == (lhs: GameModel, rhs: GameModel) -> Bool {
        if lhs.name == rhs.name && lhs.id == rhs.id && lhs.genres == rhs.genres && lhs.image == rhs.image && lhs.rating == rhs.rating && lhs.released == rhs.released {
            return true
        } else {
            return false
        }
    }
    
    let id: Int
    let name: String
    let released: String
    let image: String
    let rating: Double
    let genres: [GameGenresModel]
    
    enum CodingKeys: String, CodingKey{
        case id
        case name
        case released
        case image = "background_image"
        case rating
        case genres
    }
}
