//
//  ViewControllersFactory.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 10.11.21.
//

import Foundation

class ViewControllersFactory {
    
    static var shared = ViewControllersFactory()
    
    func createDetailsGameViewController(title: String, gameID: String) -> GameDetailsViewController {
        let gameDetailsViewController = GameDetailsViewController()
        gameDetailsViewController.title = title
        gameDetailsViewController.gameID = gameID
        return gameDetailsViewController
    }
}
