//
//  SceneDelegate.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 25.10.21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
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
    }
    
    private func createRootController() -> UIViewController {
        
        // Create games list controller
        let gamesListVC = GamesListViewController()
        gamesListVC.view.backgroundColor = Colors.backgroundColor.getUIColor()
        gamesListVC.title = "Games"
        let item = UITabBarItem()
        item.title = "Games"
        item.image = UIImage(systemName: "list.star")
        gamesListVC.tabBarItem = item
        let gamesListNavigationController = UINavigationController(rootViewController: gamesListVC)
        gamesListNavigationController.navigationBar.barTintColor = Colors.navBarColor.getUIColor()
        gamesListNavigationController.navigationBar.titleTextAttributes = [.foregroundColor: Colors.textColor.getUIColor()]
        
        let favoritesVC = FavoritesViewController()
        favoritesVC.view.backgroundColor = Colors.backgroundColor.getUIColor()
        favoritesVC.title = "Favorites"
        let item1 = UITabBarItem()
        item1.title = "Favs"
        item1.image = UIImage(systemName: "star.fill")
        favoritesVC.tabBarItem = item1
        let favoritesNavigationController = UINavigationController(rootViewController: favoritesVC)
        favoritesNavigationController.navigationBar.barTintColor = Colors.navBarColor.getUIColor()
        favoritesNavigationController.navigationBar.titleTextAttributes = [.foregroundColor: Colors.textColor.getUIColor()]
        
        let newsVC = NewsViewController()
        newsVC.view.backgroundColor = Colors.backgroundColor.getUIColor()
        newsVC.title = "News"
        let item2 = UITabBarItem()
        item2.title = "News"
        item2.image = UIImage(systemName: "book.fill")
        newsVC.tabBarItem = item2
        let newsNavigationController = UINavigationController(rootViewController: newsVC)
        newsNavigationController.navigationBar.barTintColor = Colors.navBarColor.getUIColor()
        newsNavigationController.navigationBar.titleTextAttributes = [.foregroundColor: Colors.textColor.getUIColor()]
        
        let tapBarController = UITabBarController()
        tapBarController.viewControllers = [gamesListNavigationController, favoritesNavigationController, newsNavigationController]
        
        return tapBarController
    }
}
