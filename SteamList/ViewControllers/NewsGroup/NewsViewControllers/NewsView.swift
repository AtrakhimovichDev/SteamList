//
//  NewsView.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 28.10.21.
//

import UIKit
import SnapKit

class NewsView: UIView {

    var topFilterViewConstraint: Constraint?

    var filterView: FilterView = {
        let filterView = FilterView()
        return filterView
    }()

    var blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.alpha = 0
        return blurView
    }()

    var tableView: UITableView = {
        let tableView = UITableView()
        let refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
        tableView.backgroundColor = .clear
        tableView.separatorColor = .lightGray
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        return tableView
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

    var indicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView(style: .large)
        indicatorView.color = .white
        return indicatorView
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
    }

    private func setupTableView() {
        self.addSubview(tableView)
        tableView.snp.makeConstraints { (constraints) in
            constraints.edges.equalToSuperview()
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

    func setupFilterView() {
        self.addSubview(filterView)

        filterView.snp.makeConstraints { constraints in
            topFilterViewConstraint = constraints.top.equalTo(self.bounds.height).constraint
            constraints.centerX.equalToSuperview()
            constraints.width.equalTo(self.frame.width * 0.65)
            constraints.height.equalTo(self.frame.height * 0.4)
        }
        self.layoutIfNeeded()
    }

    func addBlur() {
        self.addSubview(blurView)
        blurView.snp.makeConstraints { constraints in
            constraints.edges.equalToSuperview()
        }
        self.layoutIfNeeded()
    }

    func deleteBlur() {
        blurView.removeFromSuperview()
    }
}
