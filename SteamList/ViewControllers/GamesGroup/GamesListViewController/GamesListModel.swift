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

    init(gamesList: [GamesListItem], dataStatus: DataStatus) {
        var newGameList = [GamesListItem]()
        for item in gamesList {
            newGameList.append(GamesListItem(gameID: item.gameID, name: item.name, isFavorite: item.isFavorite))
        }
        self.gamesList = newGameList
        self.filteredGamesList = newGameList
        self.dataStatus = dataStatus
    }

    mutating func filterGamesList(searchText: String) {
        if searchText.isEmpty {
            filteredGamesList = gamesList
        } else {
            filteredGamesList = gamesList.filter {
                $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
}
