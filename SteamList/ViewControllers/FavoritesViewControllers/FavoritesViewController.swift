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
        var arr = [FavoritesItem]()
        arr.append(FavoritesItem(title: "CS: GO", price: "$9.99"))
        arr.append(FavoritesItem(title: "Dota 2", price: "Free to play"))
        arr.append(FavoritesItem(title: "Civilazation VI", price: "$17.35 (-20%)"))
        arr.append(FavoritesItem(title: "GTA V", price: "$33.99"))

        favoritesModel = FavoritesModel(dataStatus: .success,
                                        favoritesList: arr,
                                        filteredFavoritesList: arr)
        customView.searchBar.delegate = self
        customView.favsTableView.delegate = self
        customView.favsTableView.dataSource = self
        customView.favsTableView.reloadData()

        let leftBarItem = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(sortButtonPressed))
        let rightBarItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editButtonPressed))
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
        cell.titleLabel.text = favoritesModel?.filteredFavoritesList [indexPath.row].title
        cell.priceLabel.text = favoritesModel?.filteredFavoritesList[indexPath.row].price
        return cell
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
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
