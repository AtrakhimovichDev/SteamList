//
//  GameDetailsViewController.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 25.10.21.
//

import UIKit

class GameDetailsViewController: UIViewController {

    var gameID: String?
    private let customView = GameDetailsView()
    private var networkManager: NetworkManager!

    private var dataUpdateCompletion: ((Game) -> Void)?

    private var gameModel: GameDetailsModel?

    override func loadView() {
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        customView.tappedScreenshotCompletion = { [weak self] image in
            let screenshotController = ScreenshotViewController()
            // screenshotController.modalPresentationStyle = .fullScreen
            screenshotController.image = image
            self?.navigationController?.pushViewController(screenshotController, animated: true)
        }
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
        if let gameID = gameID {
            ModelsFactory.shared.createGameDetailsModel(gameID: gameID) { [weak self] gameModel in
                self?.gameModel = gameModel
                // self?.gamesListModel?.dataStatus = .error
                DispatchQueue.main.async {
                    self?.updateView()
                }
            }
        }
    }

    private func updateView() {
        guard let gameInfo = gameModel?.game else {
            return
        }
        downloadImage(from: gameInfo.headerImageURLString ?? "", to: customView.headerImageView)
        customView.nameLabel.text = gameInfo.name
        customView.descriptionLabel.text = gameInfo.shortDescription
        if gameInfo.isComingSoon {
            customView.releaseLabel.text = "Coming soon"
        } else {
            customView.releaseLabel.text = getFormatedDate(date: gameInfo.releaseDate)
        }
        if let genres = gameInfo.genres {
            var genresString = ""
            for genre in genres {
                genresString += "\(genre)    "
            }
            customView.genresLabel.text = genresString
        }
        if gameInfo.isFree {
            customView.priceLabel.text = "Free to play"
        } else {
            customView.priceLabel.text = gameInfo.price
            if let discont = gameInfo.discont,
               discont != 0 {
                customView.discontLabel.text = "-\(discont)%"
            }
        }
        if !gameInfo.isApple {
            customView.imageViewApple.isHidden = true
        }
        if !gameInfo.isLinux {
            customView.imageViewLinux.isHidden = true
        }
        if !gameInfo.isWindows {
            customView.imageViewWindows.isHidden = true
        }
        if let screenshots = gameInfo.screenshotsURLs {
            customView.createScreenShotImageViews(numbers: screenshots.count)
            for (key, screenshot) in screenshots.enumerated() {
                let imageView = customView.screenshotsViews[key]
                downloadImage(from: screenshot, to: imageView)
            }
        }
    }

    func downloadImage(from url: String, to imageView: UIImageView) {
        customView.imageViewActivityIndicator.startAnimating()
        guard let url = URL(string: url) else { return }
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { [weak self] in
                imageView.image = UIImage(data: data)
                self?.customView.imageViewActivityIndicator.stopAnimating()
            }
        }
    }

    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }

    func getFormatedDate(date: Date?) -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "d MMM, yyyy"
        let date = dateFormater.string(from: date!)
        return date
    }
}
