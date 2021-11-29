//
//  API.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 22.11.21.
//

import Foundation

enum API: String {
    case games = "https://api.steampowered.com/ISteamApps/GetAppList/v2/"
    case detailedInfo = "https://store.steampowered.com/api/appdetails"
    case news = "https://api.steampowered.com/ISteamNews/GetNewsForApp/v2/"

    func getURLString(gameID: String = "") -> String {
        switch self {
        case .games:
            return self.rawValue
        case .detailedInfo:
            return "\(self.rawValue)?appids=\(gameID)"
        case .news:
            return "\(self.rawValue)?appid=\(gameID)&count=30"
        }
    }
}
