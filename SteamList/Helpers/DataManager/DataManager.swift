//
//  DataManager.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 1.11.21.
//

import Foundation

protocol DataManager {
    func saveGamesList(gamesList: [GamesListItem])
    func getGamesList() -> [GamesListItem]
}
