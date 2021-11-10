//
//  GameDetailsModel.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 2.11.21.
//

import Foundation

struct GameDetailsModel {
    var dataStatus: DataStatus
    var game: GameDetailes?

    init(gameID: String, game: Game?, dataStatus: DataStatus) {
        self.dataStatus = dataStatus
        if let game = game {
            self.game = GameDetailes(gameID: gameID, game: game)
        }
    }
}

struct GameDetailes {
    var gameID: String
    let name: String
    let shortDescription: String
    let headerImageURLString: String?
    let isApple: Bool
    let isWindows: Bool
    let isLinux: Bool
    let isComingSoon: Bool
    var releaseDate: Date?
    var isFree: Bool
    let price: String?
    let discont: Int?
    var genres: [String]?
    var screenshotsURLs: [String]?

    init(gameID: String, game: Game) {
        self.gameID = gameID
        self.name = game.gameID!.data.name
        self.shortDescription = game.gameID!.data.shortDescription
        self.headerImageURLString = game.gameID!.data.headerImageURLString
        self.isApple = game.gameID!.data.platforms.mac
        self.isLinux = game.gameID!.data.platforms.linux
        self.isWindows = game.gameID!.data.platforms.windows
        self.isComingSoon = game.gameID!.data.releaseDate.isComingSoon
        if let priceItem = game.gameID!.data.priceItem {
            self.isFree = false
            self.price = priceItem.price
            self.discont = priceItem.discountPercent
        } else {
            self.isFree = true
            self.price = nil
            self.discont = nil
        }
        if !game.gameID!.data.releaseDate.isComingSoon {
            self.releaseDate = getDateFromString(dateString: game.gameID!.data.releaseDate.date)
        }
        if let genres = game.gameID!.data.genres {
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

    private func getDateFromString(dateString: String) -> Date {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = ""
        if let date = dateFormater.date(from: dateString) {
            return date
        }
        return Date()
    }
}
