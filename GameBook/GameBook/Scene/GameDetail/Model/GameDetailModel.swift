//
//  GameDetailModel.swift
//  GameBook
//
//  Created by Hasan Uysal on 13.12.2022.
//

import Foundation

struct GameDetailModel: Decodable {
    let name: String
    let description: String
    let released: String
    let imageUrl: String
    let additionalImageUrl: String
    let rating: Double
    let playtime: Int
    let parentPlatforms: [ParentPlatformModel]
    
    enum CodingKeys: String, CodingKey{
        case name
        case description
        case released
        case imageUrl = "background_image"
        case additionalImageUrl = "background_image_additional"
        case rating
        case playtime
        case parentPlatforms = "parent_platforms"
    }
}
