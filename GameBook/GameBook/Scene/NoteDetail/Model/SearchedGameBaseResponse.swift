//
//  SearchedGameModel.swift
//  GameBook
//
//  Created by Hasan Uysal on 18.12.2022.
//

import Foundation

struct SearchedGameBaseResponse: Decodable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [SearchedGameModel]
}
