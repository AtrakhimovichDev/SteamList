//
//  FavoritesGamesViewController.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 25.10.21.
//

import UIKit

class FavoritesViewController: UIViewController {

    private let customView = FavoritesView()
    private var favoritesModel: FavoritesModel?

    override func loadView() {
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSettings()
        setupNavBar()
        loadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    private func setupSettings() {
        customView.searchBar.delegate = self
        customView.favsTableView.delegate = self
        customView.favsTableView.dataSource = self
        customView.favsTableView.reloadData()
    }

    private func loadData() {
        ModelsFactory.shared.createFavoriteModel { [weak self] favoritesModel in
            self?.favoritesModel = favoritesModel
            DispatchQueue.main.async {
                self?.customView.favsTableView.reloadData()
            }
        }
    }

    private func setupNavBar() {
        let leftBarItem = UIBarButtonItem(title: "Sort",
                                          style: .plain,
                                          target: self,
                                          action: #selector(sortButtonPressed))
        let rightBarItem = UIBarButtonItem(title: "Edit",
                                           style: .plain,
                                           target: self,
                                           action: #selector(editButtonPressed))
        leftBarItem.tintColor = .white
        rightBarItem.tintColor = .white
        navigationItem.leftBarButtonItem = leftBarItem
        navigationItem.rightBarButtonItem = rightBarItem
    }

    @objc
    private func editButtonPressed() {
        customView.favsTableView.isEditing.toggle()
    }

    @objc
    private func sortButtonPressed() {
        let optionMenu = UIAlertController(title: nil, message: "Choose Sort", preferredStyle: .actionSheet)

        let sortByNameAction = UIAlertAction(title: "Sort by name", style: .default) { _ in
            self.sortByName()
        }
        let sortByPriceAction = UIAlertAction(title: "Sort by price", style: .default) { _ in
            self.sortByPrice()
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

        optionMenu.addAction(sortByNameAction)
        optionMenu.addAction(sortByPriceAction)
        optionMenu.addAction(cancelAction)

        self.present(optionMenu, animated: true, completion: nil)
    }

    private func sortByName() {
        favoritesModel?.filteredFavoritesList.sort { $0.title.lowercased() < $1.title.lowercased() }
        customView.favsTableView.reloadData()
    }

    private func sortByPrice() {
        favoritesModel?.filteredFavoritesList.sort { $0.price ?? 0 < $1.price ?? 0 }
        customView.favsTableView.reloadData()
    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesModel?.filteredFavoritesList.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: FavoritesTableViewCell.identifier,
                for: indexPath) as? FavoritesTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.activityIndicator.startAnimating()
        let game = favoritesModel?.filteredFavoritesList [indexPath.row]
        cell.titleLabel.text = game?.title
        cell.priceLabel.text = game?.priceTitle
        if let title = game?.priceTitle,
           !title.isEmpty {
            cell.activityIndicator.stopAnimating()
        }
        if let discont = game?.discont,
           discont != 0 {
            cell.priceLabel.textColor = Colors.discountPricaeColor.getUIColor()
        }
        return cell
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }

    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let game = favoritesModel!.filteredFavoritesList[indexPath.row]
            DataManagerImplementation.shared.deleteFavoriteGame(game: game)
            favoritesModel?.filteredFavoritesList.remove(at: indexPath.row)
            customView.favsTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension FavoritesViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        favoritesModel?.filterFavoritesList(searchText: searchText)
        self.customView.favsTableView.reloadData()
    }
}
