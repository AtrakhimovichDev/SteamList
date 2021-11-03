//
//  GamesListViewController.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 25.10.21.
//

import UIKit
import SnapKit

class GamesListViewController: UIViewController {

    private let customView: GamesListView = {
        return GamesListView()
    }()

    private var networkManager: NetworkManager = {
        return NetworkManagerImplementation()
    }()

    private var gamesListModel: GamesListModel?
    private var networkCompletion: (([GameShortInfo]) -> Void)?

    override func loadView() {
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        startIndicator()
        setupCustomView()
        loadData()
    }

    private func loadData() {
        ModelsFactory.shared.createGamesListModel { [weak self] gamesListModel in
            self?.gamesListModel = gamesListModel
            // self?.gamesListModel?.dataStatus = .error
            DispatchQueue.main.async {
                self?.customView.setupView(with: (self?.gamesListModel?.dataStatus)!)
                self?.customView.gamesTableView.reloadData()
                self?.stopIndicator()
                self?.customView.scrollView.refreshControl?.endRefreshing()
            }
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
        guard let gamesListModel = gamesListModel else { return }
        let gameDetailsViewController = GameDetailsViewController()
        gameDetailsViewController.title = gamesListModel.filteredGamesList[indexPath.row].name
        gameDetailsViewController.gameID = gamesListModel.filteredGamesList[indexPath.row].gameID
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
