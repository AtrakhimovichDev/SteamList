//
//  Game.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 25.10.21.
//

import Foundation

struct Game: Decodable {
    let gameID: GameInfo?

    private struct DynamicCodingKeys: CodingKey {

        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }

        var intValue: Int?
        init?(intValue: Int) {
            return nil
        }
    }

    init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
        var game: GameInfo?

        for key in container.allKeys {
            game = try container.decode(GameInfo.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
        }

        if let gameDecode = game {
            gameID = gameDecode
        } else {
            gameID = nil
        }
    }
}

struct GameInfo: Decodable {
    let success: Bool
    let data: GameData
}

struct GameData: Decodable {
    let name: String
    let shortDescription: String
    let headerImageURLString: String
    let genres: [GenreItem]?
    let platforms: Platforms
    let releaseDate: ReleaseDate
    let screenshots: [Screenshot]?
    let priceItem: PriceItem?

    enum CodingKeys: String, CodingKey {
        case name, platforms, genres, screenshots
        case shortDescription = "short_description"
        case headerImageURLString = "header_image"
        case releaseDate = "release_date"
        case priceItem = "price_overview"
      }
}

struct Platforms: Decodable {
    let windows: Bool
    let mac: Bool
    let linux: Bool
}

struct GenreItem: Decodable {
    let identifier: String
    let description: String

    enum CodingKeys: String, CodingKey {
        case description
        case identifier = "id"
    }
}

struct ReleaseDate: Decodable {
    let isComingSoon: Bool
    let date: String

    enum CodingKeys: String, CodingKey {
        case date
        case isComingSoon = "coming_soon"
    }
}

struct Screenshot: Decodable {
    let identifier: Int
    let imagePath: String

    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case imagePath = "path_thumbnail"
    }
}

struct PriceItem: Decodable {
    let discountPercent: Int
    let price: String

    enum CodingKeys: String, CodingKey {
        case discountPercent = "discount_percent"
        case price = "final_formatted"
    }
}
