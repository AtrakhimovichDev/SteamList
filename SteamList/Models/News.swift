//
//  News.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 20.11.21.
//

import Foundation

struct News: Decodable {
    var appnews: NewsInfo
}

struct NewsInfo: Decodable {
    var newsitems: [NewsObject]
}

struct NewsObject: Decodable {
    var gid: String
    var title: String
    var contents: String
    var author: String
    var date: Int
    var feedType: Int
    
    enum CodingKeys: String, CodingKey {
           case gid, title, contents, author, date
           case feedType = "feed_type"
       }
}
