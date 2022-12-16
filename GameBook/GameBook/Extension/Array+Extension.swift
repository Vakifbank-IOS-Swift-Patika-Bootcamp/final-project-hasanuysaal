//
//  Array+Extension.swift
//  GameBook
//
//  Created by Hasan Uysal on 16.12.2022.
//

import Foundation

extension Array where Element == GameGenresModel {
    var genresToString: String {
        let arr = self.map { $0.name }
        return arr.joined(separator: ", ")
    }
}
