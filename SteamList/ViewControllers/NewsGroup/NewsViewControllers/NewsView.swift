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
        tableView.backgroundColor = .clear
        tableView.separatorColor = .lightGray
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        return tableView
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
        self.addSubview(tableView)
        tableView.snp.makeConstraints { (constraints) in
            constraints.edges.equalToSuperview()
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
