//
//  AppDelegate.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 25.10.21.
//

import UIKit
import UserNotifications
import BackgroundTasks

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let networkManager = NetworkManagerImplementation()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        LocalNotification.shared.notificationCenter.delegate = self
        startUpdatingPrice()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
        print(#function)
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        print(#function)
    }
}

extension AppDelegate {

    private func startUpdatingPrice() {
        Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { [weak self] _ in
            let games = DataManagerImplementation.shared.getFavoritesGame()
            for game in games.0 {
                self?.checkPrice(game: game)
            }
        }
    }

    private func checkPrice(game: FavoritesItem) {
        networkManager.getDetailedGameInfo(gameID: game.gameID) { gameInfo, status in
            guard status == .success else { return }
            guard let priceItem = gameInfo?.gameID?.data.priceItem else { return }

            let currentPrice = Float(priceItem.price) / 100
            if currentPrice < game.price ?? 0 {
                LocalNotification.shared.sendNotification(
                    name: game.title,
                    price: currentPrice)
                self.saveChanges(game: game, priceItem: priceItem)
            }
        }
    }

    private func saveChanges(game: FavoritesItem, priceItem: PriceItem) {
        let favoriteItem = FavoritesItem(gameID: game.gameID,
                                         title: game.title,
                                         priceTitle: priceItem.priceTitle,
                                         price: Float(priceItem.price) / 100,
                                         discont: priceItem.discountPercent)
        DataManagerImplementation.shared.saveFavoriteGame(game: favoriteItem)
    }
}
