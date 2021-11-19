//
//  FilterView.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 19.11.21.
//

import UIKit

class FilterView: UIView {
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorColor = .lightGray
        tableView.register(FilterTableViewCell.self, forCellReuseIdentifier: FilterTableViewCell.identifier)
        return tableView
    }()

    var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.setTitleColor(Colors.additionalTextColor.getUIColor(), for: .normal)
        button.backgroundColor = Colors.navBarColor.getUIColor()
        button.layer.cornerRadius = 5
        return button
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
        self.clipsToBounds = true
        self.setGradientBackground(firstColor: Colors.firstBackgroundColor.getUIColor(),
                                   secondColor: Colors.secondBackgroundColor.getUIColor())
        self.layer.borderColor = Colors.additionalTextColor.getUIColor().cgColor
        self.layer.borderWidth = 1

        self.addSubview(tableView)
        self.addSubview(saveButton)

        tableView.snp.makeConstraints { (constraints) in
            constraints.top.leading.trailing.equalToSuperview()
        }

        saveButton.snp.makeConstraints { constraints in
            constraints.leading.equalToSuperview().offset(40)
            constraints.trailing.equalToSuperview().offset(-40)
            constraints.bottom.equalToSuperview().offset(-20)
            constraints.top.equalTo(tableView.snp.bottom).offset(20)
        }
    }
}
