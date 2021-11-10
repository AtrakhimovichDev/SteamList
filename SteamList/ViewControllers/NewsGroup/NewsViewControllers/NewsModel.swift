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
}

struct NewsItem {
    var title: String
    var gameName: String
    var author: String
    var date: Date
    var contents: String
}
