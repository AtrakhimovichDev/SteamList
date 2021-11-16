//
//  FavoritesModel.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 9.11.21.
//

import Foundation

struct FavoritesModel {
    var dataStatus: DataStatus
    var favoritesList: [FavoritesItem]
    var filteredFavoritesList: [FavoritesItem]

    mutating func filterFavoritesList(searchText: String) {
        if searchText.isEmpty {
            filteredFavoritesList = favoritesList
        } else {
            filteredFavoritesList = favoritesList.filter {
                $0.title.lowercased().contains(searchText.lowercased()) }
        }
    }
}

class FavoritesItem {
    init(gameID: String, title: String, priceTitle: String? = nil, price: Float? = nil, discont: Int? = nil) {
        self.gameID = gameID
        self.title = title
        self.priceTitle = priceTitle
        self.price = price
        self.discont = discont
    }
    
    var gameID: String
    var title: String
    var priceTitle: String?
    var price: Float?
    var discont: Int?
}
