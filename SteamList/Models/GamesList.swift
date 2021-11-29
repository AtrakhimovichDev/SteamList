//
//  Games.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 25.10.21.
//

import Foundation

struct GamesList: Decodable {
    let applist: Applications
}

struct Applications: Decodable {
    let apps: [GameShortInfo]
}

struct GameShortInfo: Decodable {
    let appid: Int
    let name: String
}
