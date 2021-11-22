//
//  NewsModel.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 10.11.21.
//

import Foundation

struct NewsModel {
    var dataStatus: DataStatus
    var news: [NewsItem]
    var filteredNews: [NewsItem]
    var filteredGames: [FilterItem]
}

struct NewsItem {
    var gameID: String
    var title: String
    var gameName: String
    var author: String
    var date: Date
    var contents: String
}

struct FilterItem {
    var gameID: String
    var name: String
    var isEnabled: Bool
}
