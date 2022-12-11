//
//  GameResponseModel.swift
//  GameBook
//
//  Created by Hasan Uysal on 11.12.2022.
//

import Foundation

struct GamesResponseModel: Decodable {
    let next: String
    let previous: String?
    let results: [GameModel]
}
