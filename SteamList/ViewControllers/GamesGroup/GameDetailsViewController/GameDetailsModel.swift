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

    init(gameID: String, game: GameDetails?, dataStatus: DataStatus) {
        self.dataStatus = dataStatus
        self.game = game
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
    var isFavorite: Bool = false
    var releaseDate: Date?
    var isFree: Bool = false
    var priceTitle: String?
    var price: Float?
    var discont: Int?
    var genres: [String]?
    var screenshotsURLs: [String]?

    init?(gameID: String, game: Game?) {
        guard let gameInfo = game?.gameID else { return }
        self.gameID = gameID
        self.name = gameInfo.data.name
        self.shortDescription = gameInfo.data.shortDescription
        self.headerImageURLString = gameInfo.data.headerImageURLString
        self.isApple = gameInfo.data.platforms.mac
        self.isLinux = gameInfo.data.platforms.linux
        self.isWindows = gameInfo.data.platforms.windows
        self.isComingSoon = gameInfo.data.releaseDate.isComingSoon
        self.isFavorite = false
        if let priceItem = gameInfo.data.priceItem {
            self.isFree = false
            self.price = Float(priceItem.price) / 100
            self.priceTitle = priceItem.priceTitle
            self.discont = priceItem.discountPercent
        } else {
            self.isFree = true
        }
        if !gameInfo.data.releaseDate.isComingSoon {
            self.releaseDate = CustomDateFormater.shared.getDate(from: gameInfo.data.releaseDate.date)
        }
        if let genres = gameInfo.data.genres {
            self.genres = [String]()
            for genre in genres {
                self.genres?.append(genre.description)
            }
        }
        if let screenshots = gameInfo.data.screenshots {
            self.screenshotsURLs = [String]()
            for screenshot in screenshots {
                self.screenshotsURLs?.append(screenshot.imagePath)
            }
        }
    }

    init(gameID: String, game: GameDetailedInfo) {
        self.gameID = gameID
        self.name = game.name
        self.shortDescription = game.gameDescription
        self.headerImageURLString = game.headerImageURL
        self.isApple = game.isApple
        self.isLinux = game.isLinux
        self.isWindows = game.isWindows
        self.isComingSoon = game.isCoomingSoon
        self.isFavorite = false
        self.isFree = game.isFree
        self.price = game.price
        self.priceTitle = game.priceTitle
        self.discont = Int(game.discont)
        self.releaseDate = game.releaseDate
        self.genres = game.genres
        self.screenshotsURLs = game.screensotsURL
    }
}
