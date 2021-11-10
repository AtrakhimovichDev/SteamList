//
//  GameDetailsViewController.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 25.10.21.
//

import UIKit

class GameDetailsViewController: UIViewController {

    var gameID: String!

    private let customView = GameDetailsView()
    private var gameModel: GameDetailsModel!

    private var networkManager: NetworkManager = NetworkManagerImplementation()

    override func loadView() {
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSettings()
        loadData()
    }

    private func setupSettings() {
        customView.tappedScreenshotCompletion = { [weak self] image in
            let screenshotController = ViewControllersFactory.shared.createScreenshotVC(image: image)
            self?.navigationController?.pushViewController(screenshotController, animated: true)
        }
    }

    private func loadData() {
        ModelsFactory.shared.createGameDetailsModel(gameID: gameID) { [weak self] gameModel in
            self?.gameModel = gameModel
            DispatchQueue.main.async {
                guard let status = self?.gameModel.dataStatus else { return }
                self?.customView.setupView(with: status)
                self?.updateView()
            }
        }
    }

    private func updateView() {
        guard gameModel.dataStatus == .success,
            let gameInfo = gameModel.game else {
            return
        }
        fillHeaderImage(gameInfo: gameInfo)
        fillName(gameInfo: gameInfo)
        fillDescription(gameInfo: gameInfo)
        fillReleaseDate(gameInfo: gameInfo)
        fillGenres(gameInfo: gameInfo)
        fillPrice(gameInfo: gameInfo)
        fillPlatforms(gameInfo: gameInfo)
        fillScreenshots(gameInfo: gameInfo)
    }

    private func fillHeaderImage(gameInfo: GameDetails) {
        if let url = gameInfo.headerImageURLString {
            customView.imageViewActivityIndicator.startAnimating()
            downloadImage(from: url, to: customView.headerImageView)
        } else {
            setDefaultImage()
        }
    }

    private func fillName(gameInfo: GameDetails) {
        customView.nameLabel.text = gameInfo.name
    }

    private func fillDescription(gameInfo: GameDetails) {
        customView.descriptionLabel.text = gameInfo.shortDescription
    }

    private func fillReleaseDate(gameInfo: GameDetails) {
        if gameInfo.isComingSoon {
            customView.releaseLabel.text = "Coming soon"
        } else {
            if let date = gameInfo.releaseDate {
                customView.releaseLabel.text = CustomDateFormater.shared.getString(from: date)
            }
        }
    }

    private func fillGenres(gameInfo: GameDetails) {
        if let genres = gameInfo.genres {
            var genresString = ""
            for genre in genres {
                genresString += "\(genre)    "
            }
            customView.genresLabel.text = genresString
        }
    }

    private func fillPrice(gameInfo: GameDetails) {
        if gameInfo.isFree {
            customView.priceLabel.text = "Free to play"
        } else {
            customView.priceLabel.text = gameInfo.price
            if let discont = gameInfo.discont,
               discont != 0 {
                customView.discontLabel.text = "-\(discont)%"
            }
        }
    }

    private func fillPlatforms(gameInfo: GameDetails) {
        if !gameInfo.isApple {
            customView.imageViewApple.isHidden = true
        }
        if !gameInfo.isLinux {
            customView.imageViewLinux.isHidden = true
        }
        if !gameInfo.isWindows {
            customView.imageViewWindows.isHidden = true
        }
    }

    private func fillScreenshots(gameInfo: GameDetails) {
        if let screenshots = gameInfo.screenshotsURLs {
            customView.createScreenShotImageViews(numbers: screenshots.count)
            for (key, screenshot) in screenshots.enumerated() {
                let imageView = customView.screenshotsViews[key]
                downloadImage(from: screenshot, to: imageView)
            }
        }
    }

    private func setDefaultImage() {
        customView.headerImageView.image = UIImage(named: "default_game_image")
    }

    func downloadImage(from url: String, to imageView: UIImageView) {
        networkManager.downloadImage(url: url) { data in
            DispatchQueue.main.async { [weak self] in
                imageView.image = UIImage(data: data)
                self?.customView.imageViewActivityIndicator.stopAnimating()
            }
        }
    }
}
