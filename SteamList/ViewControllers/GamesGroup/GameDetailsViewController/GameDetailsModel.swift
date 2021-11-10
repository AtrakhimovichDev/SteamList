//
//  GameDetailsModel.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 2.11.21.
//

import Foundation

struct GameDetailsModel {
    var dataStatus: DataStatus
    var game: GameDetails?

    init(gameID: String, game: Game?, dataStatus: DataStatus) {
        if let game = game {
            self.dataStatus = dataStatus
            self.game = GameDetails(gameID: gameID, game: game)
        } else {
            self.dataStatus = .empty
        }
    }
}

struct GameDetails {
    var gameID: String = ""
    var name: String = ""
    var shortDescription: String = ""
    var headerImageURLString: String?
    var isApple: Bool = false
    var isWindows: Bool = false
    var isLinux: Bool = false
    var isComingSoon: Bool = false
    var releaseDate: Date?
    var isFree: Bool = false
    var price: String?
    var discont: Int?
    var genres: [String]?
    var screenshotsURLs: [String]?

    init?(gameID: String, game: Game) {
        guard let gameInfo = game.gameID else { return }
        self.gameID = gameID
        self.name = gameInfo.data.name
        self.shortDescription = gameInfo.data.shortDescription
        self.headerImageURLString = gameInfo.data.headerImageURLString
        self.isApple = gameInfo.data.platforms.mac
        self.isLinux = gameInfo.data.platforms.linux
        self.isWindows = gameInfo.data.platforms.windows
        self.isComingSoon = gameInfo.data.releaseDate.isComingSoon
        if let priceItem = gameInfo.data.priceItem {
            self.isFree = false
            self.price = priceItem.price
            self.discont = priceItem.discountPercent
        } else {
            self.isFree = true
            self.price = nil
            self.discont = nil
        }
        if !game.gameID!.data.releaseDate.isComingSoon {
            self.releaseDate = CustomDateFormater.shared.getDate(from: gameInfo.data.releaseDate.date)
        }
        if let genres = gameInfo.data.genres {
            self.genres = [String]()
            for genre in genres {
                self.genres?.append(genre.description)
            }
        }
        if let screenshots = game.gameID!.data.screenshots {
            self.screenshotsURLs = [String]()
            for screenshot in screenshots {
                self.screenshotsURLs?.append(screenshot.imagePath)
            }
        }
    }
}
