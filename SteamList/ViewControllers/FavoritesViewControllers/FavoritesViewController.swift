//
//  FavoritesGamesViewController.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 25.10.21.
//

import UIKit

class FavoritesViewController: UIViewController {

    private let customView = FavoritesView()

    override func loadView() {
        view = customView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
