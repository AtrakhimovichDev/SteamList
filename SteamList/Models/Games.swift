//
//  Games.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 25.10.21.
//

import Foundation

struct Games: Decodable {
    let applist: [Applications]
}

struct Applications: Decodable {
    let apps: [Game]
}

struct Game: Decodable {
    let appid: String
    let name: String
}
