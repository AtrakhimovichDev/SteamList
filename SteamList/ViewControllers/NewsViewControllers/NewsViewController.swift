//
//  NewsViewController.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 25.10.21.
//

import UIKit

class NewsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func setupSettings() {
        setGradientBackground()
        title = "News"
        let item = UITabBarItem()
        item.title = "News"
        item.image = UIImage(systemName: "book.fill")
        tabBarItem = item
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
