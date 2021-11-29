//
//  NetworkManager.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 25.10.21.
//

import Foundation

class NetworkManagerImplementation: NetworkManager {
   
    func downloadImage(url: String, completion: @escaping ((Data) -> Void)) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data,
                  error == nil else {
                return
            }
            completion(data)
        }.resume()
    }

    func getAllGames(completion: @escaping (([GamesListItem], DataStatus) -> Void)) {
        guard let url = URL(string: API.games.getURLString()) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in

            if let error = error {
                print(error)
                completion([GamesListItem](), .error)
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                return
            }

            if let data = data {
                 do {
                    let res = try JSONDecoder().decode(GamesList.self, from: data)
                    if res.applist.apps.count == 0 {
                        completion([GamesListItem](), .empty)
                        return
                    }
                    var listResult = [GamesListItem]()
                    for item in res.applist.apps {
                        let gameItem = GamesListItem(gameID: String(item.appid), name: item.name)
                        listResult.append(gameItem)
                    }
                    completion(listResult.filter { $0.name != "" }, .success)
                 } catch let error {
                    print(error)
                 }
              }
        }.resume()
    }

    func getDetailedGameInfo(gameID: String, completion: @escaping ((Game?, DataStatus) -> Void)) {
        guard let url = URL(string: API.detailedInfo.getURLString(gameID: gameID)) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in

            if let error = error {
                print(error)
                completion(nil, .error)
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(nil, .error)
                return
            }

            if let data = data {
                 do {
                    let result = try JSONDecoder().decode(Game.self, from: data)
                    if let game = result.gameID,
                       game.success {
                        completion(result, .success)
                    } else {
                        completion(nil, .empty)
                    }
                 } catch let error {
                    print(error)
                    completion(nil, .error)
                 }
              }
        }.resume()
    }

    func getNews(games: [FavoritesItem], completion: @escaping (([(gameID: String, name: String, news: News)]?, DataStatus) -> Void)) {

        var news = [(gameID: String, name: String, news: News)]()
        let dispatchGroup = DispatchGroup()

        for game in games {
            dispatchGroup.enter()
            guard let url = URL(string: API.news.getURLString(gameID: game.gameID)) else { return }
            URLSession.shared.dataTask(with: url, completionHandler: { (data, _, error) in
                guard let data = data,
                    let subject = try? JSONDecoder().decode(News.self, from: data) else {
                        dispatchGroup.leave()
                        print(error?.localizedDescription ?? "")
                        return
                }
                news.append((game.gameID, game.title, subject))
                dispatchGroup.leave()
            }).resume()
        }

        dispatchGroup.notify(queue: DispatchQueue.global()) {
            if news.isEmpty {
                completion(nil, .empty)
            } else {
                completion(news, .success)
            }
        }
    }
}
