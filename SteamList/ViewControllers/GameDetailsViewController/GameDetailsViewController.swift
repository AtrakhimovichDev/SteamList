//
//  GameDetailsViewController.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 25.10.21.
//

import UIKit

class GameDetailsViewController: UIViewController {

    var gameID: Int?
    private let customView = GameDetailsView()
    private var networkManager: NetworkManager!

    private var dataUpdateCompletion: ((Game) -> Void)?

    // private var gameModel: Game?

    override func loadView() {
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSettings()
        fetchData()
    }

    private func setupSettings() {
        networkManager = NetworkManagerImplementation()
        dataUpdateCompletion = { game in
            if let url = URL(string: game.gameID?.data.headerImageURLString ?? "") {
                let data = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    self.customView.headerImageView.image = UIImage(data: data!)
                }
            }
            DispatchQueue.main.async {
                self.customView.nameLabel.text = game.gameID?.data.name
            }
        }
    }

    private func fetchData() {
        guard let gameID = gameID,
              let completion = dataUpdateCompletion else {
            return
        }
        networkManager.getDetailedGameInfo(gameID: String(gameID)) { game in
            completion(game)
        }
    }
}
