//
//  Double+Extension.swift
//  GameBook
//
//  Created by Hasan Uysal on 11.12.2022.
//

import Foundation

extension Double {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(format: "%.1f", self)
    }
}
