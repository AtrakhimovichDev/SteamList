//
//  GamesListModel.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 1.11.21.
//

import Foundation

struct GamesListModel {
    var gamesList: [GamesListItem]
    var filteredGamesList: [GamesListItem]
    var dataStatus: DataStatus?

    init(gamesList: [GameShortInfo]) {
        var newGameList = [GamesListItem]()
        for item in gamesList {
            newGameList.append(GamesListItem(gameID: item.appid, name: item.name))
        }
        self.gamesList = newGameList
        self.filteredGamesList = newGameList
    }

    init(gamesList: [GamesListItem]) {
        var newGameList = [GamesListItem]()
        for item in gamesList {
            newGameList.append(GamesListItem(gameID: item.gameID, name: item.name))
        }
        self.gamesList = newGameList
        self.filteredGamesList = newGameList
    }
}
