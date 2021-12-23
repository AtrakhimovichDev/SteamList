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

    func createMainNavControllerController() -> UIViewController {

        // MARK: Create games list controller
        let gamesListVC = GamesListViewController()
        gamesListVC.title = "Games"
        let gamesListNavigationController = createNavigationController(
                                                        rootViewController: gamesListVC,
                                                        tapBarName: "Games",
                                                        tapBarImage: "list.star")

        // MARK: Create games favorites controller
        let favoritesVC = FavoritesViewController()
        favoritesVC.title = "Favorites"
        let favoritesNavigationController = createNavigationController(
                                                        rootViewController: favoritesVC,
                                                        tapBarName: "Favs",
                                                        tapBarImage: "star.fill")

        // MARK: Create games news controller
        let newsVC = NewsViewController()
        newsVC.title = "News"
        let newsNavigationController = createNavigationController(
                                                        rootViewController: newsVC,
                                                        tapBarName: "News",
                                                        tapBarImage: "book.fill")

        let tapBarController = UITabBarController()
        tapBarController.viewControllers = [gamesListNavigationController,
                                            favoritesNavigationController,
                                            newsNavigationController]

        return tapBarController
    }

    private func createNavigationController(rootViewController: UIViewController,
                                            tapBarName: String,
                                            tapBarImage: String) -> UINavigationController {

        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.navigationBar.barTintColor = Colors.navBarColor.getUIColor()
        navigationController.navigationBar.titleTextAttributes = [.foregroundColor: Colors.textColor.getUIColor()]
        navigationController.tabBarItem = UITabBarItem(title: tapBarName,
                                                       image: UIImage(systemName: tapBarImage), tag: 0)
        return navigationController

    }
}
