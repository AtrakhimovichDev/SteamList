//
//  GamesListItem.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 1.11.21.
//

import Foundation

class GamesListItem {

    var gameID: String
    var name: String
    var isFavorite: Bool

    init(gameID: String, name: String, isFavorite: Bool = false) {
        self.gameID = gameID
        self.name = name
        self.isFavorite = isFavorite
    }
}
