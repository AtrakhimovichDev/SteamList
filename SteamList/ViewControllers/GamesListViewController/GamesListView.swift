//
//  GamesListView.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 25.10.21.
//

import UIKit

class GamesListView: UIView {

    var searchBar: UISearchBar!
    var gamesTableView: UITableView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubViews()
    }

    convenience init() {
        self.init(frame: UIScreen.main.bounds)
        createSubViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createSubViews()
    }

    private func createSubViews() {
        backgroundColor = .clear
        createSearchBar()
        createTableView()
    }

    private func createSearchBar() {

        searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.textColor = .white
        searchBar.searchTextField.tintColor = .white
        searchBar.searchTextField.leftView?.tintColor = .lightGray
        self.addSubview(searchBar)
        searchBar.snp.makeConstraints { (constraints) in
            constraints.top.equalToSuperview()
            constraints.leading.equalToSuperview().offset(5)
            constraints.trailing.equalToSuperview().offset(-5)
        }
    }

    private func createTableView() {

        gamesTableView = UITableView()
        gamesTableView.backgroundColor = .clear
        gamesTableView.separatorColor = .lightGray
        gamesTableView.register(GamesListTableViewCell.self, forCellReuseIdentifier: GamesListTableViewCell.identifier)
        self.addSubview(gamesTableView)
        gamesTableView.snp.makeConstraints { (constraints) in
            constraints.top.equalTo(searchBar.snp.bottomMargin).offset(10)
            constraints.leading.equalToSuperview()
            constraints.trailing.equalToSuperview()
            constraints.bottom.equalToSuperview()
        }
    }
}
