//
//  ViewControllersFactory.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 10.11.21.
//

import UIKit

class ViewControllersFactory {

    static var shared = ViewControllersFactory()

    func createDetailsGameVC(title: String, gameID: String) -> GameDetailsViewController {
        let gameDetailsViewController = GameDetailsViewController()
        gameDetailsViewController.title = title
        gameDetailsViewController.gameID = gameID
        return gameDetailsViewController
    }

    func createScreenshotVC(image: UIImage) -> ScreenshotViewController {
        let screenshotController = ScreenshotViewController()
        screenshotController.image = image
        return screenshotController
    }

    func createDetailedNewsVS(newsID: String) -> DetailedNewsViewController {
        let newsController = DetailedNewsViewController()
        newsController.newsID = newsID
        return newsController
    }
}
