//
//  NewsViewController.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 25.10.21.
//

import UIKit

class NewsViewController: UIViewController {

    private var customView = NewsView()
    private var newsModel: NewsModel?
    let networkManager = NetworkManagerImplementation()

    override func loadView() {
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSettings()
        loadData()
    }

    private func setupSettings() {
        let rightBarItem = UIBarButtonItem(title: "Filter",
                                           style: .plain,
                                           target: self,
                                           action: #selector(filterButtonPressed))
        rightBarItem.tintColor = .white
        navigationItem.rightBarButtonItem = rightBarItem

        customView.tableView.delegate = self
        customView.tableView.dataSource = self

        customView.tableView.reloadData()

        customView.filterView.saveButton.addTarget(self, action: #selector(saveFilterSettings), for: .touchUpInside)
    }

    private func loadData() {
        ModelsFactory.shared.createNewsModel(completion: { [weak self] newsModel in
            self?.newsModel = newsModel
            DispatchQueue.main.async {
                self?.customView.tableView.reloadData()
            }
        })
    }

    @objc
    private func saveFilterSettings() {
        navigationItem.rightBarButtonItem?.isEnabled = true
        UIView.animate(withDuration: 0.5) {
            self.customView.blurView.alpha = 0
            self.customView.topFilterViewConstraint?.update(offset: self.customView.frame.height)
            self.customView.layoutIfNeeded()
        } completion: { _ in
            self.customView.deleteBlur()
            self.customView.filterView.removeFromSuperview()
        }

    }

    @objc
    private func filterButtonPressed() {
        navigationItem.rightBarButtonItem?.isEnabled = false
        customView.addBlur()
        UIView.animate(withDuration: 0.5) {
            self.customView.blurView.alpha = 1
        }
        customView.setupFilterView()
        UIView.animate(withDuration: 0.5) {
            let yPoint = self.customView.frame.height / 2 - self.customView.filterView.frame.height / 2
            self.customView.topFilterViewConstraint?.update(offset: yPoint)
            self.customView.layoutIfNeeded()
        }
    }
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsModel?.filteredNews.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: NewsTableViewCell.identifier,
                for: indexPath) as? NewsTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        guard let newsModel = newsModel else { return cell }
        cell.fillInfo(info: newsModel.news[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
