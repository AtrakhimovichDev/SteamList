//
//  GamesListViewController.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 25.10.21.
//

import UIKit
import SnapKit

class GamesListViewController: UIViewController {

    private let customView = GamesListView()

    private var dataManager: DataManager?
    private var networkManager: NetworkManager?

    private var gamesListModel: GamesListModel?

    private var networkCompletion: (([GameShortInfo]) -> Void)?

    override func loadView() {
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        startIndicator()
        setupCustomView()
        setupNetworkSettings()
        setupDataManager()
        loadData()
        view.addGestureRecognizer(createOutOfSerchTap())
    }

    private func loadData() {
        let needUpdate = true
        if needUpdate {
            if let networkManager = networkManager,
               let networkCompletion = networkCompletion {
                networkManager.getAllGames { games in
                    networkCompletion(games)
                }
            }
        } else {
            guard let dataManager = dataManager else { return }
            gamesListModel = GamesListModel(gamesList: dataManager.getGamesList())
            self.stopIndicator()
        }
    }

    private func setupNetworkSettings() {
        networkManager = NetworkManagerImplementation()
        networkCompletion = { [weak self] games in
            self?.gamesListModel = GamesListModel(gamesList: games)
            DispatchQueue.main.async {
                self?.customView.gamesTableView.reloadData()
                self?.stopIndicator()
            }
            if let gamesListModel = self?.gamesListModel {
                self?.dataManager?.saveGamesList(gamesList: gamesListModel.gamesList)
            }
        }
    }

    private func setupDataManager() {
        dataManager = CoreDataManager()
    }

    private func setupCustomView() {
        customView.gamesTableView.delegate = self
        customView.gamesTableView.dataSource = self
        customView.searchBar.delegate = self
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

    private func startIndicator() {
        customView.indicatorView.isHidden = false
        customView.indicatorView.startAnimating()
    }

    private func stopIndicator() {
        customView.indicatorView.stopAnimating()
        customView.indicatorView.isHidden = true
    }
}

extension GamesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gamesListModel?.filteredGamesList.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: GamesListTableViewCell.identifier,
                for: indexPath) as? GamesListTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.titleLabel.text = gamesListModel?.filteredGamesList[indexPath.row].name ?? ""
        return cell
    }
}

extension GamesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // print(filteredGames[indexPath.row].appid)
        let gameDetailsViewController = GameDetailsViewController()
        gameDetailsViewController.title = gamesListModel?.filteredGamesList[indexPath.row].name
        gameDetailsViewController.gameID = gamesListModel?.filteredGamesList[indexPath.row].gameID
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
        guard var gamesListModel = gamesListModel else {
            return
        }
        if searchText.isEmpty {
            gamesListModel.filteredGamesList = gamesListModel.gamesList
        } else {
            gamesListModel.filteredGamesList = gamesListModel.gamesList.filter {
                $0.name.lowercased().contains(searchText.lowercased()) }
        }
        self.gamesListModel = gamesListModel
        self.customView.gamesTableView.reloadData()
    }
}
