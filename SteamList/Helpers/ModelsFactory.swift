//
//  ModelsFactory.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 2.11.21.
//

import Foundation

class ModelsFactory {

    static var shared = ModelsFactory()

    private var networkManager: NetworkManager = NetworkManagerImplementation()

    // MARK: - List model -
    func createGamesListModel(completion: @escaping ((GamesListModel) -> Void)) {
        let needUpdate = true
        if needUpdate {
            getListModelFromNetwork(completion: completion)
        } else {
            getListModelFromDatabase(completion: completion)
        }
    }

    private func getListModelFromNetwork(completion: @escaping ((GamesListModel) -> Void)) {
        networkManager.getAllGames { (gamesList, dataStatus) in
            DataManagerImplementation.shared.addFavoriteFlag(list: gamesList)
            let gamesListModel = GamesListModel(gamesList: gamesList, dataStatus: dataStatus)
            completion(gamesListModel)
            if dataStatus == .success {
                DataManagerImplementation.shared.saveGamesList(gamesList: gamesList)
            }
        }
    }

    private func getListModelFromDatabase(completion: @escaping ((GamesListModel) -> Void)) {
        let result = getListFromDatabase()
        let gamesListModel = GamesListModel(gamesList: result.0, dataStatus: result.1)
        completion(gamesListModel)
    }

    private func getListFromDatabase() -> ([GamesListItem], DataStatus) {
        let result = DataManagerImplementation.shared.getGamesList()
        return result
    }

    // MARK: - Details model -
    func createGameDetailsModel(gameID: String, completion: @escaping ((GameDetailsModel) -> Void)) {
        getDetailsModelFromDatabase(gameID: gameID, completion: completion)
        getDetailsModelFromNetwork(gameID: gameID, completion: completion)
    }

    private func getDetailsModelFromNetwork(gameID: String, completion: @escaping ((GameDetailsModel) -> Void)) {
        networkManager.getDetailedGameInfo(gameID: gameID, completion: { (game, dataStatus) in
            let gameDetails = GameDetails(gameID: gameID, game: game)
            var gameDetailsModel = GameDetailsModel(gameID: gameID, game: gameDetails, dataStatus: dataStatus)
            gameDetailsModel.game?.isFavorite = self.isFavorite(gameID: gameID)
            completion(gameDetailsModel)
            if dataStatus == .success,
               let gameDetails = gameDetails {
                DataManagerImplementation.shared.saveDetailedInfo(game: gameDetails)
                if self.isFavorite(gameID: gameID),
                   let game = gameDetailsModel.game {
                    let favoriteItem = FavoritesItem(gameID: game.gameID,
                                                     title: game.name,
                                                     priceTitle: game.priceTitle,
                                                     price: game.price,
                                                     discont: game.discont)
                    DataManagerImplementation.shared.saveFavoriteGame(game: favoriteItem)
                }
            }
        })
    }

    private func getDetailsModelFromDatabase(gameID: String, completion: @escaping ((GameDetailsModel) -> Void)) {
        let gameDetails = getDetailsFromDatabase(gameID: gameID)
        var gameDetailsModel = GameDetailsModel(gameID: gameID, game: gameDetails.0, dataStatus: gameDetails.1)
        gameDetailsModel.game?.isFavorite = isFavorite(gameID: gameID)
        if gameDetailsModel.dataStatus == .success {
            completion(gameDetailsModel)
        }
    }

    private func getDetailsFromDatabase(gameID: String) -> (GameDetails?, DataStatus) {
        let result = DataManagerImplementation.shared.getDetailedInfo(gameID: gameID)
        return result
    }

    // MARK: - Favorites model -
    func createFavoriteModel(completion: @escaping ((FavoritesModel) -> Void)) {
        let favoritesModel = getFavoritesModelFromDatabase(completion: completion)
        updateFavoritesModelFromNetwork(model: favoritesModel, completion: completion)
    }

    private func getFavoritesModelFromDatabase(completion: @escaping ((FavoritesModel) -> Void)) -> FavoritesModel {
        let favoritesGames = getFavoritesFromDatabase()
        let favoritesModel = FavoritesModel(dataStatus: favoritesGames.1,
                                              favoritesList: favoritesGames.0,
                                              filteredFavoritesList: favoritesGames.0)
        if favoritesModel.dataStatus == .success {
            completion(favoritesModel)
        }
        return favoritesModel
    }

    private func updateFavoritesModelFromNetwork(model: FavoritesModel,
                                                 completion: @escaping ((FavoritesModel) -> Void)) {
        for favItem in model.favoritesList {
            networkManager.getDetailedGameInfo(gameID: favItem.gameID) { (game, _) in
                if let priceItem = game?.gameID?.data.priceItem {
                    favItem.price = Float(priceItem.price) / 100
                    favItem.discont = priceItem.discountPercent
                    favItem.priceTitle = "$\(String(format: "%.2f", favItem.price!)) USD"
                    if priceItem.discountPercent != 0 {
                        favItem.priceTitle = "\(favItem.priceTitle!) (-\(priceItem.discountPercent)%)"
                    }
                } else {
                    favItem.priceTitle = "Free"
                }
                DataManagerImplementation.shared.saveFavoriteGame(game: favItem)
                completion(model)
            }
        }
    }

    private func getFavoritesFromDatabase() -> ([FavoritesItem], DataStatus) {
        let result = DataManagerImplementation.shared.getFavoritesGame()
        return result
    }

    // MARK: - News model -
    func createNewsModel(completion: @escaping ((NewsModel) -> Void)) {
        // getDetailsModelFromDatabase(gameID: gameID, completion: completion)
        getDetailsModelFromNetwork(completion: completion)
    }

    private func getDetailsModelFromNetwork(completion: @escaping ((NewsModel) -> Void)) {
        let favoritesGames = DataManagerImplementation.shared.getFavoritesGame()
        networkManager.getNews(games: favoritesGames.0) { news, dataStatus in
            guard dataStatus == .success,
                  let news = news else { return }
            let newsItems = self.createNewsItems(news: news)
            let filteredGames = self.createFilteredGames(favoritesGames: favoritesGames.0)
            let newsModel = NewsModel(dataStatus: dataStatus,
                                      news: newsItems,
                                      filteredNews: newsItems,
                                      filteredGames: filteredGames)
            completion(newsModel)
        }
    }

    private func createNewsItems(news: [(gameID: String, name: String, news: News)]) -> [NewsItem] {
        var newsItems = [NewsItem]()
        for item in news {
            for element in item.news.appnews.newsitems {
                let newsItem = NewsItem(gameID: item.gameID,
                                        title: element.title,
                                        gameName: item.name,
                                        author: element.author,
                                        date: CustomDateFormater.shared.getDate(from: element.date),
                                        contents: element.contents)
                newsItems.append(newsItem)
            }
        }
        newsItems.sort { $0.date > $1.date }
        return newsItems
    }

    private func createFilteredGames(favoritesGames: [FavoritesItem]) -> [FilterItem] {
        var filterItems = [FilterItem]()
        for item in favoritesGames {
            let filterItem = FilterItem(gameID: item.gameID,
                                        name: item.title,
                                        isEnabled: true)
            filterItems.append(filterItem)
        }
        return filterItems
    }

    // MARK: - Additional functions -
    private func isFavorite(gameID: String) -> Bool {
        if let _ = DataManagerImplementation.shared.findFavoriteGame(gameID: gameID) {
            return true
        } else {
            return false
        }
    }
}
