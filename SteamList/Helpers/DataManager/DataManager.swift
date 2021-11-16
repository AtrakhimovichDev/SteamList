//
//  DataManager.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 1.11.21.
//

import Foundation

protocol DataManager {
    func saveFavoriteGame(game: FavoritesItem)
    func getFavoritesGame() -> ([FavoritesItem], DataStatus)
    func saveGamesList(gamesList: [GamesListItem])
    func getGamesList() -> ([GamesListItem], DataStatus)
    func saveDetailedInfo(game: GameDetails)
    func getDetailedInfo(gameID: String) -> (GameDetails?, DataStatus)
}
