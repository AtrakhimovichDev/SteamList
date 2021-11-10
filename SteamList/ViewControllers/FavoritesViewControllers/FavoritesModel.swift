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

struct FavoritesItem {
    var title: String
    var price: String
}
