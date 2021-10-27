//
//  NetworkManager.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 25.10.21.
//

import Foundation

class NetworkManagerImplementation: NetworkManager {

    func getAllGames(completion: @escaping (([GameShortInfo]) -> Void)) {
        guard let url = URL(string: "https://api.steampowered.com/ISteamApps/GetAppList/v2/") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print(error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                return
            }
            
            if let data = data {
                 do {
                    let res = try JSONDecoder().decode(GamesList.self, from: data)
                    completion(res.applist.apps.filter { $0.name != "" })
                 } catch let error {
                    print(error)
                 }
              }
        }.resume()
    }
    
    func getDetailedGameInfo(gameID: String, completion: @escaping ((Game) -> Void)) {
        guard let url = URL(string: "https://store.steampowered.com/api/appdetails?appids=\(gameID)") else { return }
        
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print(error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                return
            }
            
            if let data = data {
                 do {
                    let result = try JSONDecoder().decode(Game.self, from: data)
                    completion(result)
                 } catch let error {
                    print(error)
                 }
              }
        }.resume()
    }
}
