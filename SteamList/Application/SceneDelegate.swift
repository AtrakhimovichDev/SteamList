//
//  SceneDelegate.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 25.10.21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        // guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let window = UIWindow(windowScene: windowScene)
        let rootViewController = createRootController()
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        self.window = window
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // (UIApplication.shared.delegate as? AppDelegate)?.scheduleBackgroundPokemonFetch()
    }

    private func createRootController() -> UIViewController {

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
