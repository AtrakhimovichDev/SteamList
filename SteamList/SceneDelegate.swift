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
        
        // MARK: Create games list controller
        let gamesListVC = GamesListViewController()
        gamesListVC.setupSettings()
        let gamesListNavigationController = createNavigationController(rootViewController: gamesListVC)
        
        // MARK: Create games favorites controller
        let favoritesVC = FavoritesViewController()
        favoritesVC.setupSettings()
        let favoritesNavigationController = createNavigationController(rootViewController: favoritesVC)
       
        // MARK: Create games news controller
        let newsVC = NewsViewController()
        newsVC.setupSettings()
        let newsNavigationController = createNavigationController(rootViewController: newsVC)
        
        let tapBarController = UITabBarController()
        tapBarController.viewControllers = [gamesListNavigationController, favoritesNavigationController, newsNavigationController]
        
        return tapBarController
    }
    
    private func createNavigationController(rootViewController: UIViewController) -> UINavigationController {
        
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.navigationBar.barTintColor = Colors.navBarColor.getUIColor()
        navigationController.navigationBar.titleTextAttributes = [.foregroundColor: Colors.textColor.getUIColor()]
        return navigationController
    }
}
