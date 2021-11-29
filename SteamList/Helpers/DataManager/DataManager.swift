//
//  DataManager.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 1.11.21.
//

import Foundation

protocol DataManager {
    // MARK: - Games list -
    func saveGamesList(gamesList: [GamesListItem])
    func getGamesList() -> ([GamesListItem], DataStatus)
    
    // MARK: - Games detailed info -
    func saveDetailedInfo(game: GameDetails)
    func getDetailedInfo(gameID: String) -> (GameDetails?, DataStatus)

    // MARK: - Favorites games -
    func saveFavoriteGame(game: FavoritesItem)
    func getFavoritesGame() -> ([FavoritesItem], DataStatus)
    
    // MARK: - News -
    func saveNews(newsList: [NewsItem])
    func getNews(newsID: String) -> (NewsItem?, DataStatus)
}
