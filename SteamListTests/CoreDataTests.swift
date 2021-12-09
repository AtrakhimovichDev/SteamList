//
//  CoreDataTests.swift
//  SteamListTests
//
//  Created by Andrei Atrakhimovich on 2.12.21.
//

import XCTest
@testable import SteamList

class CoreDataTests: XCTestCase {

    var sut: DataManager!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = CoreDataStub()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
}

class CoreDataStub: DataManager {
    func saveGamesList(gamesList: [GamesListItem]) {
        <#code#>
    }
    
    func getGamesList() -> ([GamesListItem], DataStatus) {
        <#code#>
    }
    
    func saveDetailedInfo(game: GameDetails) {
        <#code#>
    }
    
    func getDetailedInfo(gameID: String) -> (GameDetails?, DataStatus) {
        <#code#>
    }
    
    func saveFavoriteGame(game: FavoritesItem) {
        <#code#>
    }
    
    func getFavoritesGame() -> ([FavoritesItem], DataStatus) {
        <#code#>
    }
    
    func saveNews(newsList: [NewsItem]) {
        <#code#>
    }
    
    func getNews(newsID: String) -> (NewsItem?, DataStatus) {
        <#code#>
    }
    
    
}
