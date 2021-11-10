//
//  ModelsFactory.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 2.11.21.
//

import Foundation

class ModelsFactory {

    static var shared = ModelsFactory()

    private var networkManager: NetworkManager = {
        return NetworkManagerImplementation()
    }()

    func createGamesListModel(completion: @escaping ((GamesListModel) -> Void)) {
        let needUpdate = true
        if needUpdate {
            getListFromNetwork(completion: completion)
        } else {
            let result = getListFromDatabase()
            let gamesListModel = GamesListModel(gamesList: result.0, dataStatus: result.1)
            completion(gamesListModel)
        }
    }

    func createGameDetailsModel(gameID: String, completion: @escaping ((GameDetailsModel) -> Void)) {
        let needUpdate = true
        if needUpdate {
            getDetailsFromNetwork(gameID: gameID, completion: completion)
        } else {
//            let result = getDetailsFromDatabase()
//            let gamesListModel = GamesListModel(gamesList: result.0, dataStatus: result.1)
//            completion(gamesListModel)
        }
    }

    private func getListFromNetwork(completion: @escaping ((GamesListModel) -> Void)) {
        networkManager.getAllGames { (gamesList, dataStatus) in
            let gamesListModel = GamesListModel(gamesList: gamesList, dataStatus: dataStatus)
            completion(gamesListModel)
            if dataStatus == .success {
                DataManagerImplementation.shared.saveGamesList(gamesList: gamesList)
            }
        }
    }

    private func getListFromDatabase() -> ([GamesListItem], DataStatus) {
        let result = DataManagerImplementation.shared.getGamesList()
        return result
    }

    private func getDetailsFromNetwork(gameID: String, completion: @escaping ((GameDetailsModel) -> Void)) {
        networkManager.getDetailedGameInfo(gameID: gameID, completion: { (game, dataStatus) in
            let gameDetailsModel = GameDetailsModel(gameID: gameID, game: game, dataStatus: dataStatus)
            completion(gameDetailsModel)
            if dataStatus == .success {
                // write in database
            }
        })
    }
}
