//
//  NetworkManager.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 26.10.21.
//

import Foundation

protocol NetworkManager {
    func downloadImage(url: String, completion: @escaping ((Data) -> Void))
    func getAllGames(completion: @escaping (([GamesListItem], DataStatus) -> Void))
    func getDetailedGameInfo(gameID: String, completion: @escaping ((Game?, DataStatus) -> Void))
    func getNews(games: [FavoritesItem],
                 completion: @escaping (([(gameID: String, name: String, news: News)]?, DataStatus) -> Void))
}
