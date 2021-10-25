//
//  GamesListViewController.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 25.10.21.
//

import UIKit
import SnapKit

class GamesListViewController: UIViewController {

    var customView: UIView!
    var games = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCustomView()

        games.append("Game 1")
        games.append("Game 2")
        games.append("Game 3")
        games.append("Game 4")
        games.append("Game 5")
        games.append("Game 6")
        games.append("Game 7")
    }

    private func setupCustomView() {
        let customView = GamesListView(frame: view.frame)
        view.addSubview(customView)
        customView.snp.makeConstraints { (constarints) in
            constarints.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            constarints.leading.equalToSuperview()
            constarints.trailing.equalToSuperview()
            constarints.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin)
        }
        customView.gamesTableView.delegate = self
        customView.gamesTableView.dataSource = self
        self.customView = customView
    }

    func setupSettings() {
//        self.view.setGradientBackground(firstColor: Colors.firstBackgroundColor.getUIColor(),
//                                   secondColor: Colors.secondBackgroundColor.getUIColor())
        setGradientBackground()
        title = "Games"
        tabBarItem = UITabBarItem(title: "Games", image: UIImage(systemName: "list.star"), tag: 0)
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

extension GamesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: GamesListTableViewCell.identifier,
                for: indexPath) as? GamesListTableViewCell else {
            return UITableViewCell()
        }
        cell.titleLabel.text = games[indexPath.row]
        return cell
    }
}

extension GamesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
