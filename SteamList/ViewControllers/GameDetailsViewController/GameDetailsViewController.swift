//
//  GameDetailsViewController.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 25.10.21.
//

import UIKit

class GameDetailsViewController: UIViewController {

    var customView: GameDetailsView!
    var gameModel: Game? {
        didSet {
            if let url = URL(string: gameModel?.gameID?.data.headerImageURLString ?? "") {
                let data = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    self.customView.headerImage.image = UIImage(data: data!)
                }
            }
            DispatchQueue.main.async {
                self.customView.nameLabel.text = self.gameModel?.gameID?.data.name
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCustomView()
        setGradientBackground()
    }

    private func setupCustomView() {
        let customView = GameDetailsView(frame: view.bounds)
        view.addSubview(customView)
        customView.snp.makeConstraints { (constarints) in
            constarints.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            constarints.leading.equalToSuperview()
            constarints.trailing.equalToSuperview()
            constarints.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin)
        }
        self.customView = customView
    }
    
    private func setGradientBackground() {
        let colorTop =  Colors.firstBackgroundColor.getUIColor().cgColor
        let colorBottom = Colors.secondBackgroundColor.getUIColor().cgColor

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds

        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
}
