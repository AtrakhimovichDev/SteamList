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
    var indicatorView: UIActivityIndicatorView!

    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        createSubViews()
    }

    convenience init() {
        self.init(frame: UIScreen.main.bounds)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createSubViews()
    }

    private func createSubViews() {
        self.setGradientBackground(firstColor: Colors.firstBackgroundColor.getUIColor(),
                                   secondColor: Colors.secondBackgroundColor.getUIColor())
        createSearchBar()
        createTableView()
        createActivityIndicator()
    }

    private func createSearchBar() {

        searchBar = UISearchBar()
        self.addSubview(searchBar)
        searchBar.placeholder = "Search"
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.textColor = .white
        searchBar.searchTextField.tintColor = .white
        searchBar.searchTextField.leftView?.tintColor = .lightGray

        searchBar.snp.makeConstraints { (constraints) in
            constraints.top.equalToSuperview()
            constraints.leading.equalToSuperview().offset(5)
            constraints.trailing.equalToSuperview().offset(-5)
        }
    }

    private func createTableView() {

        gamesTableView = UITableView()
        self.addSubview(gamesTableView)
        gamesTableView.backgroundColor = .clear
        gamesTableView.separatorColor = .lightGray
        gamesTableView.register(GamesListTableViewCell.self, forCellReuseIdentifier: GamesListTableViewCell.identifier)

        gamesTableView.snp.makeConstraints { (constraints) in
            constraints.top.equalTo(searchBar.snp.bottomMargin).offset(10)
            constraints.leading.equalToSuperview()
            constraints.trailing.equalToSuperview()
            constraints.bottom.equalToSuperview()
        }
    }

    private func createActivityIndicator() {
        indicatorView = UIActivityIndicatorView(style: .large)
        indicatorView.color = .white
        self.addSubview(indicatorView)
        indicatorView.snp.makeConstraints { constraints in
            constraints.center.equalToSuperview()
        }
    }
}
