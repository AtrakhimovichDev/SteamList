//
//  SteamListSlowTests.swift
//  SteamListSlowTests
//
//  Created by Andrei Atrakhimovich on 17.11.21.
//

import XCTest
@testable import SteamList

class SteamListSlowTests: XCTestCase {

    var sut: NetworkManager!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = NetworkManagerStub()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testApiCallGetAllGames() throws {

        let promise = expectation(description: "No error in games list request")
        sut.getAllGames { gamesList, dataStatus in
            XCTAssertEqual(gamesList.count, 3)
            XCTAssertEqual(dataStatus, .success)
            promise.fulfill()
        }
        wait(for: [promise], timeout: 5)
    }

    func testApiCallGetDetailedGameInfo() {
        let promise = expectation(description: "No error in game details")
        sut.getDetailedGameInfo(gameID: "") { game, dataStatus in
            XCTAssertNotNil(game)
            XCTAssertEqual(dataStatus, .success)
            promise.fulfill()
        }
        wait(for: [promise], timeout: 5)
    }

    func testApiCallGetNews() {
//        let promise = expectation(description: "No error in news")
//        sut.getNews(games: <#T##[FavoritesItem]#>) { <#[(gameID: String, name: String, news: News)]?#>, <#DataStatus#> in
//            <#code#>
//        }
//        sut.getNews(games: [FavoritesItem]()) { (result, dataStatus) in
//            XCTAssertEqual(result news.count, 3)
//            XCTAssertEqual(dataStatus, .success)
//            promise.fulfill()
//        }
//        wait(for: [promise], timeout: 5)
    }
}

class NetworkManagerStub: NetworkManager {

    func getAllGames(completion: @escaping (([GamesListItem], DataStatus) -> Void)) {
        let fileName = "JSONSuccessGamesList"
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            completion([GamesListItem](), .error)
            return
        }
        do {
            let data = try Data(contentsOf: url)
            let result = try JSONDecoder().decode(GamesList.self, from: data)
            var resultArr = [GamesListItem]()
            for item in result.applist.apps {
                let newItem = GamesListItem(gameID: String(item.appid), name: item.name)
                resultArr.append(newItem)
            }
            completion(resultArr, .success)
        } catch {
            completion([GamesListItem](), .error)
        }
    }

    func getDetailedGameInfo(gameID: String, completion: @escaping ((Game?, DataStatus) -> Void)) {
        let fileName = "JSONSuccessGame"
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            completion(nil, .error)
            return
        }
        do {
            let data = try Data(contentsOf: url)
            let result = try JSONDecoder().decode(Game.self, from: data)
            completion(result, .success)
        } catch {
            completion(nil, .error)
        }
    }

    func getNews(games: [FavoritesItem], completion: @escaping (([(gameID: String, name: String, news: News)]?, DataStatus) -> Void)) {
    }

    func downloadImage(url: String, completion: @escaping ((Data) -> Void)) {
    }
}
