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
    private var gamesListModel: GamesListModel?

    private let networkManager: NetworkManager = NetworkManagerImplementation()

    override func loadView() {
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        startIndicator()
        setupCustomView()
        loadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateData()
    }

    private func loadData() {
        ModelsFactory.shared.createGamesListModel { [weak self] gamesListModel in
            self?.gamesListModel = gamesListModel
            DispatchQueue.main.async {
                guard let status = self?.gamesListModel?.dataStatus else { return }
                self?.customView.setupView(with: status)
                self?.customView.gamesTableView.reloadData()
                self?.stopIndicator()
                self?.customView.scrollView.refreshControl?.endRefreshing()
            }
        }
    }

    private func updateData() {
        if let gamesListModel = gamesListModel {
            DataManagerImplementation.shared.updateFavoritesInfo(list: gamesListModel.filteredGamesList)
            customView.gamesTableView.reloadData()
            DataManagerImplementation.shared.updateFavoritesInfo(list: gamesListModel.gamesList)
        }
    }

    private func setupCustomView() {
        customView.gamesTableView.delegate = self
        customView.gamesTableView.dataSource = self
        customView.searchBar.delegate = self
        customView.scrollView.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }

    private func startIndicator() {
        customView.indicatorView.isHidden = false
        customView.indicatorView.startAnimating()
    }

    private func stopIndicator() {
        customView.indicatorView.stopAnimating()
        customView.indicatorView.isHidden = true
    }

    @objc private func refresh() {
        self.loadData()
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
        guard let gameItem = gamesListModel?.filteredGamesList[indexPath.row] else {
            return UITableViewCell()
        }
        cell.setup(gameItem: gameItem, index: indexPath.row)
        cell.favButton.addTarget(self, action: #selector(favButtonTapped(handler:)), for: .touchUpInside)
        return cell
    }

    @objc private func favButtonTapped(handler: UIButton) {
        guard let gamesListModel = gamesListModel else { return }
        let selectedGame = gamesListModel.filteredGamesList[handler.tag]
        selectedGame.isFavorite.toggle()
        if let button = handler as? FavoriteButton {
            button.setIcon(isFavorite: selectedGame.isFavorite)
        }
        let favoritesItem = FavoritesItem(gameID: selectedGame.gameID,
                                          title: selectedGame.name,
                                          priceTitle: "",
                                          price: 0,
                                          discont: 0)
        if selectedGame.isFavorite {
            DataManagerImplementation.shared.saveFavoriteGame(game: favoritesItem)
        } else {
            DataManagerImplementation.shared.deleteFavoriteGame(game: favoritesItem)
        }
    }
}

extension GamesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let gamesListModel = gamesListModel else { return }
        let gameDetailsViewController = ViewControllersFactory.shared.createDetailsGameVC(
            title: gamesListModel.filteredGamesList[indexPath.row].name,
            gameID: gamesListModel.filteredGamesList[indexPath.row].gameID)
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
        gamesListModel?.filterGamesList(searchText: searchText)
        self.customView.gamesTableView.reloadData()
    }
}
