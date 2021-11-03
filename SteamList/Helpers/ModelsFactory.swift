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
        let needUpdate = false
        if needUpdate {
            getFromNetwork(completion: completion)
        } else {
            let result = getFromDatabase()
            let gamesListModel = GamesListModel(gamesList: result.0, dataStatus: result.1)
            completion(gamesListModel)
        }
    }

    private func getFromNetwork(completion: @escaping ((GamesListModel) -> Void)) {
        networkManager.getAllGames { (gamesList, dataStatus) in
            let gamesListModel = GamesListModel(gamesList: gamesList, dataStatus: dataStatus)
            completion(gamesListModel)
            if dataStatus == .success {
                DataManagerImplementation.shared.saveGamesList(gamesList: gamesList)
            }
        }
    }

    private func getFromDatabase() -> ([GamesListItem], DataStatus) {
        let result = DataManagerImplementation.shared.getGamesList()
        return result
    }
}
