//
//  GamesListViewController.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 25.10.21.
//

import UIKit
import SnapKit

class GamesListViewController: UIViewController {
    
    var networkManager: NetworkManager!
    var customView: GamesListView!
    var games = [GameShortInfo]()
    var filteredGames = [GameShortInfo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNetworkManager()
        setupCustomView()
        view.addGestureRecognizer(createOutOfSerchTap())
        networkManager.getAllGames { [weak self] games in
            self?.games = games
            self?.filteredGames = games
            DispatchQueue.main.async {
                self?.customView.gamesTableView.reloadData()
            }
        }
    }

    private func setupNetworkManager() {
        networkManager = NetworkManagerImplementation()
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
        customView.searchBar.delegate = self
        self.customView = customView
    }

    func setupSettings() {
//        self.view.setGradientBackground(firstColor: Colors.firstBackgroundColor.getUIColor(),
//                                   secondColor: Colors.secondBackgroundColor.getUIColor())
        setGradientBackground()
        title = "Games"
        tabBarItem = UITabBarItem(title: "Games", image: UIImage(systemName: "list.star"), tag: 0)
    }

    private func createOutOfSerchTap() -> UITapGestureRecognizer {
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(singleTap))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        return singleTapGestureRecognizer
    }

    @objc private func singleTap() {
        self.customView.searchBar.endEditing(true)
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
        return filteredGames.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: GamesListTableViewCell.identifier,
                for: indexPath) as? GamesListTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none;
        cell.titleLabel.text = filteredGames[indexPath.row].name
        return cell
    }
}

extension GamesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(filteredGames[indexPath.row].appid)
        let gameDetailsViewController = GameDetailsViewController()
        networkManager.getDetailedGameInfo(gameID: String(filteredGames[indexPath.row].appid)) { game in
            print(game)
            gameDetailsViewController.gameModel = game
        }
        gameDetailsViewController.title = filteredGames[indexPath.row].name
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .white
        navigationController?.pushViewController(gameDetailsViewController, animated: true)
    }
}

extension GamesListViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredGames = games
        } else {
            filteredGames = games.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
        self.customView.gamesTableView.reloadData()
    }
}
