//
//  CoreDataManager.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 1.11.21.
//

import Foundation
import CoreData
import FirebaseDatabase

class DataManagerImplementation: DataManager {

    static var shared = DataManagerImplementation()

    private var context: NSManagedObjectContext

    private init() {
        let persistentContainer: NSPersistentContainer = {
            let container = NSPersistentContainer(name: "Games")
            container.loadPersistentStores(completionHandler: { (_, error) in
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
            return container
        }()
        context = persistentContainer.newBackgroundContext()
    }

    // MARK: - Games list functions -

    func getGamesList() -> ([GamesListItem], DataStatus) {
        let fetchRequest: NSFetchRequest<GameItem> = GameItem.fetchRequest()
        do {
            let objects = try context.fetch(fetchRequest)
            if objects.count == 0 {
                return ([GamesListItem](), .empty)
            }
            var list = [GamesListItem]()
            for item in objects {
                let newItem = GamesListItem(gameID: String(item.gameID), name: item.name)
                list.append(newItem)
            }
            addFavoriteFlag(list: list)
            return (list, .success)
        } catch {
            return ([GamesListItem](), .error)
        }
    }

    func saveGamesList(gamesList: [GamesListItem]) {
        clearGamesList()
        for item in gamesList {
            let gameItem = GameItem(context: context)
            gameItem.gameID = item.gameID
            gameItem.name = item.name
        }
        saveContext()
    }

    private func clearGamesList() {
        let fetchRequest: NSFetchRequest<GameItem> = GameItem.fetchRequest()
        do {
            let objects = try context.fetch(fetchRequest)
            for item in objects {
                context.delete(item)
            }
            saveContext()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }

    // MARK: - Game details functions -

    func getDetailedInfo(gameID: String) -> (GameDetails?, DataStatus) {
        let fetchRequest: NSFetchRequest<GameDetailedInfo> = GameDetailedInfo.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "gameID LIKE %@", gameID)
        do {
            let object = try context.fetch(fetchRequest)
            if let game = object.first {
                let gameDetailedInfo = GameDetails(gameID: gameID, game: game)
                return (gameDetailedInfo, .success)
            } else {
                return (nil, .empty)
            }
        } catch {
            return (nil, .error)
        }
    }

    func saveDetailedInfo(game: GameDetails) {
        let coreDataObject = findDetailedInfo(gameID: game.gameID)
        if let coreDataObject = coreDataObject {
            coreDataObject.name = game.name
            coreDataObject.gameDescription = game.shortDescription
            coreDataObject.headerImageURL = game.headerImageURLString
            coreDataObject.isApple = game.isApple
            coreDataObject.isLinux = game.isLinux
            coreDataObject.isWindows = game.isWindows
            coreDataObject.isCoomingSoon = game.isComingSoon
            coreDataObject.isFree = game.isFree
            coreDataObject.price = game.price ?? 0
            coreDataObject.priceTitle = game.priceTitle
            coreDataObject.discont = Int16(game.discont ?? 0)
            coreDataObject.releaseDate = game.releaseDate
            coreDataObject.genres = game.genres
            coreDataObject.screensotsURL = game.screenshotsURLs
        } else {
            let detailedInfo = GameDetailedInfo(context: context)
            detailedInfo.gameID = game.gameID
            detailedInfo.name = game.name
            detailedInfo.gameDescription = game.shortDescription
            detailedInfo.headerImageURL = game.headerImageURLString
            detailedInfo.isApple = game.isApple
            detailedInfo.isLinux = game.isLinux
            detailedInfo.isWindows = game.isWindows
            detailedInfo.isCoomingSoon = game.isComingSoon
            detailedInfo.isFree = game.isFree
            detailedInfo.price = game.price ?? 0
            detailedInfo.priceTitle = game.priceTitle
            detailedInfo.discont = Int16(game.discont ?? 0)
            detailedInfo.releaseDate = game.releaseDate
            detailedInfo.genres = game.genres
            detailedInfo.screensotsURL = game.screenshotsURLs
        }

        saveContext()
    }

    private func findDetailedInfo(gameID: String) -> GameDetailedInfo? {
        let fetchRequest: NSFetchRequest<GameDetailedInfo> = GameDetailedInfo.fetchRequest()

        fetchRequest.predicate = NSPredicate(
            format: "gameID LIKE %@", gameID
        )
        if let objects = try? context.fetch(fetchRequest) {
            return objects.first
        } else {
            return nil
        }
    }

    // MARK: - Favorites functions -

    func getFavoritesGame() -> ([FavoritesItem], DataStatus) {
        let fetchRequest: NSFetchRequest<FavoriteGame> = FavoriteGame.fetchRequest()
        do {
            let objects = try context.fetch(fetchRequest)
            if objects.count == 0 {
                return ([FavoritesItem](), .empty)
            }
            var list = [FavoritesItem]()
            for item in objects {
                let newItem = FavoritesItem(gameID: item.gameID,
                                            title: item.name,
                                            priceTitle: item.priceTitle,
                                            price: item.price,
                                            discont: Int(item.discont))
                list.append(newItem)
            }
            return (list, .success)
        } catch {
            return ([FavoritesItem](), .error)
        }
    }

    func saveFavoriteGame(game: FavoritesItem) {
        let coreDataObject = findFavoriteGame(gameID: game.gameID)
        if let coreDataObject = coreDataObject {
            coreDataObject.gameID = game.gameID
            coreDataObject.name = game.title
            coreDataObject.price = game.price ?? 0
            coreDataObject.priceTitle = game.priceTitle ?? ""
            coreDataObject.discont = Int16(game.discont ?? 0)
        } else {
            let favoriteGame = FavoriteGame(context: context)
            favoriteGame.gameID = game.gameID
            favoriteGame.name = game.title
            favoriteGame.price = game.price ?? 0
            favoriteGame.priceTitle = game.priceTitle ?? ""
            favoriteGame.discont = Int16(game.discont ?? 0)
        }
        saveContext()
        let ref = Database.database(url: "https://steam-list-default-rtdb.europe-west1.firebasedatabase.app").reference(withPath: "favorite-games")
        let groceryItemRef = ref.child(game.gameID.lowercased())
        groceryItemRef.setValue(["title": game.title])
    }

    func findFavoriteGame(gameID: String) -> FavoriteGame? {
        let fetchRequest: NSFetchRequest<FavoriteGame> = FavoriteGame.fetchRequest()

        fetchRequest.predicate = NSPredicate(
            format: "gameID LIKE %@", gameID
        )
        if let objects = try? context.fetch(fetchRequest) {
            return objects.first
        } else {
            return nil
        }
    }

    func addFavoriteFlag(list: [GamesListItem]) {
        let favoritesGames = getFavoritesGame().0
        for game in favoritesGames {
            if let findedGame = list.filter({ $0.gameID == game.gameID }).first {
                findedGame.isFavorite = true
            }
        }
    }

    func updateFavoritesInfo(list: [GamesListItem]) {
        for game in list {
            game.isFavorite = false
        }
        addFavoriteFlag(list: list)
    }

    func deleteFavoriteGame(game: FavoritesItem) {
        let coreDataObject = findFavoriteGame(gameID: game.gameID)
        if let coreDataObject = coreDataObject {
            context.delete(coreDataObject)
        }
        saveContext()
    }

    // MARK: - News functions -
    func saveNews(newsList: [NewsItem]) {
        clearNews()
        for item in newsList {
            let newsItem = NewsDetailedInfo(context: context)
            newsItem.newsID = item.id
            newsItem.gameID = item.gameID
            newsItem.title = item.title
            newsItem.gameName = item.gameName
            newsItem.date = item.date
            newsItem.author = item.author
            newsItem.contents = item.contents
        }
        saveContext()
    }

    func getNews(newsID: String) -> (NewsItem?, DataStatus) {
        let fetchRequest: NSFetchRequest<NewsDetailedInfo> = NewsDetailedInfo.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "newsID LIKE %@", newsID)
        do {
            let object = try context.fetch(fetchRequest)
            if let news = object.first {
                let newsDetailedInfo = NewsItem(id: news.newsID,
                                                gameID: news.gameID,
                                                title: news.title,
                                                gameName: news.gameName,
                                                author: news.author,
                                                date: news.date,
                                                contents: news.contents)
                return (newsDetailedInfo, .success)
            } else {
                return (nil, .empty)
            }
        } catch {
            return (nil, .error)
        }
    }

    private func clearNews() {
        let fetchRequest: NSFetchRequest<NewsDetailedInfo> = NewsDetailedInfo.fetchRequest()
        do {
            let objects = try context.fetch(fetchRequest)
            for item in objects {
                context.delete(item)
            }
            saveContext()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }

    // MARK: - Common functions -
    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                context.rollback()
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
