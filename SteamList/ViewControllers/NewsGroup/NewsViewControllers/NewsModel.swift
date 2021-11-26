//
//  NewsModel.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 10.11.21.
//

import Foundation

class NewsModel {
    var dataStatus: DataStatus
    var news: [NewsItem]
    var filteredNews: [NewsItem]
    var filteredGames: [FilterItem]

    init(dataStatus: DataStatus, news: [NewsItem], filteredNews: [NewsItem], filteredGames: [FilterItem]) {
        self.dataStatus = dataStatus
        self.news = news
        self.filteredNews = filteredNews
        self.filteredGames = filteredGames
    }
}

class NewsItem {
    var id: String
    var gameID: String
    var title: String
    var gameName: String
    var author: String
    var date: Date
    var contents: String

    init(id: String, gameID: String, title: String, gameName: String, author: String, date: Date, contents: String) {
        self.id = id
        self.gameID = gameID
        self.title = title
        self.gameName = gameName
        self.author = author
        self.date = date
        self.contents = contents
    }
}

class FilterItem {
    var gameID: String
    var name: String
    var isEnabled: Bool

    init(gameID: String, name: String, isEnabled: Bool) {
        self.gameID = gameID
        self.name = name
        self.isEnabled = isEnabled
    }
}
