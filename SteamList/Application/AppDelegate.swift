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

    private func startUpdatingPrice() {
        Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { _ in
            let games = DataManagerImplementation.shared.getFavoritesGame()
            for game in games.0 {
                self.networkManager.getDetailedGameInfo(gameID: game.gameID) { gameInfo, status in
                    if status == .success,
                       let gameInfo = gameInfo {
                        if let price = gameInfo.gameID?.data.priceItem {
                            if Float(price.price) / 100 < game.price ?? 0 {
                                LocalNotification.shared.sendNotification(
                                    name: game.title,
                                    price: Float(price.price) / 100)
                                // save new price
                            }
                        }
                    }
                }
            }
        }
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
