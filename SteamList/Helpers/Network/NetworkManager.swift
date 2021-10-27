//
//  NetworkManager.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 26.10.21.
//

import Foundation

protocol NetworkManager {
    func getAllGames(completion: @escaping (([GameShortInfo]) -> Void))
    func getDetailedGameInfo(gameID: String, completion: @escaping ((Game) -> Void))
}
