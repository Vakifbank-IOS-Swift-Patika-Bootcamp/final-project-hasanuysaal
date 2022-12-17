//
//  CustomError.swift
//  GameBook
//
//  Created by Hasan Uysal on 17.12.2022.
//

import Foundation

enum CustomError: Error {
    case favoriteGameNotFound
    case gameNotFound
    case noteNotCreate
    case noteNotUpdate
    case imageNotPick
    case gameNameNotEnter
    case gameNoteNotEnter
    case unexpected(code: Int)
}

extension CustomError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .favoriteGameNotFound:
            return NSLocalizedString(
                "There is no game on favorite list. You will be redirected to the home page.", comment: "")
        case .gameNotFound:
            return NSLocalizedString(
                "Game not found. You will be redirected to the home page.", comment: "")
        case .noteNotCreate:
            return NSLocalizedString("An error occurred while creating the note!", comment: "")
        case .noteNotUpdate:
            return NSLocalizedString("An error occurred while updating the note!", comment: "")
        case .imageNotPick:
            return NSLocalizedString("You should pick an image before saving note!", comment: "")
        case .gameNameNotEnter:
            return NSLocalizedString("You should enter game name before saving note!", comment: "")
        case .gameNoteNotEnter:
            return NSLocalizedString("You should enter note before saving note!", comment: "")
        case .unexpected(_):
            return NSLocalizedString(
                "An unexpected error occurred.",
                comment: ""
            )
        }
    }
}
