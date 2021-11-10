//
//  FavoritesView.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 28.10.21.
//

import UIKit

class FavoritesView: UIView {

    var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.textColor = .white
        searchBar.searchTextField.tintColor = .white
        searchBar.searchTextField.leftView?.tintColor = .lightGray
        return searchBar
    }()

    var favsTableView: UITableView = {
        let favsTableView = UITableView()
        favsTableView.backgroundColor = .clear
        favsTableView.separatorColor = .lightGray
        favsTableView.register(FavoritesTableViewCell.self, forCellReuseIdentifier: FavoritesTableViewCell.identifier)
        return favsTableView
    }()

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

        self.addSubview(searchBar)
        searchBar.snp.makeConstraints { (constraints) in
            constraints.top.equalTo(safeAreaLayoutGuide.snp.top)
            constraints.leading.equalToSuperview().offset(5)
            constraints.trailing.equalToSuperview().offset(-5)
        }

        self.addSubview(favsTableView)
        favsTableView.snp.makeConstraints { (constraints) in
            constraints.top.equalTo(searchBar.snp.bottomMargin).offset(10)
            constraints.leading.equalToSuperview()
            constraints.trailing.equalToSuperview()
            constraints.bottom.equalToSuperview()
        }
    }
}
