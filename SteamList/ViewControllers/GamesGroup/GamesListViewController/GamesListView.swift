//
//  GamesListView.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 25.10.21.
//

import UIKit

class GamesListView: UIView {

    var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.textColor = .white
        searchBar.searchTextField.tintColor = .white
        searchBar.searchTextField.leftView?.tintColor = .lightGray
        return searchBar
    }()

    var gamesTableView: UITableView = {
        let gamesTableView = UITableView()
        gamesTableView.backgroundColor = .clear
        gamesTableView.separatorColor = .lightGray
        gamesTableView.register(GamesListTableViewCell.self, forCellReuseIdentifier: GamesListTableViewCell.identifier)
        return gamesTableView
    }()

    var indicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView(style: .large)
        indicatorView.color = .white
        return indicatorView
    }()

    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        scrollView.refreshControl = refreshControl
        return scrollView
    }()

    private var errorLabel: UILabel = {
        let errorLabel = UILabel()
        errorLabel.textColor = .white
        return errorLabel
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

    func setupView(with dataStatus: DataStatus) {
        switch dataStatus {
        case .success:
            setupSearchBar()
            setupTableView()
        case .empty:
            setupScrollView()
            setupErrorLabel(text: "Oops... No data here")
        case .error:
            setupScrollView()
            setupErrorLabel(text: "Oops... Something go wrong")
        }
    }

    private func createSubViews() {
        self.setGradientBackground(firstColor: Colors.firstBackgroundColor.getUIColor(),
                                   secondColor: Colors.secondBackgroundColor.getUIColor())
        setupActivityIndicator()
        self.addGestureRecognizer(createOutOfSerchTap())
    }

    private func setupSearchBar() {

        self.addSubview(searchBar)
        searchBar.snp.makeConstraints { (constraints) in
            constraints.top.equalTo(safeAreaLayoutGuide.snp.top)
            constraints.leading.equalToSuperview().offset(5)
            constraints.trailing.equalToSuperview().offset(-5)
        }
    }

    private func setupTableView() {

        self.addSubview(gamesTableView)
        gamesTableView.snp.makeConstraints { (constraints) in
            constraints.top.equalTo(searchBar.snp.bottomMargin).offset(10)
            constraints.leading.equalToSuperview()
            constraints.trailing.equalToSuperview()
            constraints.bottom.equalToSuperview()
        }
    }

    private func setupScrollView() {
        self.addSubview(scrollView)
        scrollView.snp.makeConstraints { constraints in
            constraints.top.equalTo(safeAreaLayoutGuide.snp.top)
            constraints.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            constraints.leading.equalToSuperview()
            constraints.trailing.equalToSuperview()
        }
    }

    private func setupErrorLabel(text: String) {
        scrollView.addSubview(errorLabel)
        errorLabel.text = text
        errorLabel.snp.makeConstraints { constraints in
            constraints.center.equalToSuperview()
        }
    }

    private func setupActivityIndicator() {

        self.addSubview(indicatorView)
        indicatorView.snp.makeConstraints { constraints in
            constraints.center.equalToSuperview()
        }
    }

    private func createOutOfSerchTap() -> UITapGestureRecognizer {
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(singleTap))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        return singleTapGestureRecognizer
    }

    @objc private func singleTap() {
        self.searchBar.endEditing(true)
    }
}
