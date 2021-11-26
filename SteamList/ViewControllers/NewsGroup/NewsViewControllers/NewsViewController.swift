//
//  NewsViewController.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 25.10.21.
//

import UIKit

class NewsViewController: UIViewController {

    private let filterTableViewController = FilterTableViewController()
    private var customView = NewsView()
    private var newsModel: NewsModel?
    let networkManager = NetworkManagerImplementation()

    override func loadView() {
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        startIndicator()
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
        customView.tableView.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        customView.filterView.tableView.delegate = filterTableViewController
        customView.filterView.tableView.dataSource = filterTableViewController

        customView.tableView.reloadData()

        customView.filterView.saveButton.addTarget(self, action: #selector(saveFilterSettings), for: .touchUpInside)
    }

    private func loadData() {
        ModelsFactory.shared.createNewsModel(completion: { [weak self] newsModel in
            self?.newsModel = newsModel
            self?.filterTableViewController.newsModel = newsModel
            DispatchQueue.main.async {
                self?.customView.setupView(with: newsModel.dataStatus)
                self?.customView.tableView.reloadData()
                self?.customView.filterView.tableView.reloadData()
                self?.customView.tableView.refreshControl?.endRefreshing()
                self?.stopIndicator()
            }
        })
    }

    private func startIndicator() {
        customView.indicatorView.isHidden = false
        customView.indicatorView.startAnimating()
    }

    private func stopIndicator() {
        customView.indicatorView.stopAnimating()
        customView.indicatorView.isHidden = true
    }

    @objc
    private func refresh() {
        self.loadData()
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
        guard let newsModel = newsModel else { return }
        var gamesID = [String]()
        for game in newsModel.filteredGames where game.isEnabled {
            gamesID.append(game.gameID)
        }
        newsModel.filteredNews = newsModel.news.filter { gamesID.contains($0.gameID) }
        customView.tableView.reloadData()
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
        cell.fillInfo(info: newsModel.filteredNews[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let newsModel = newsModel else { return }
        let newsDetailedVC = ViewControllersFactory.shared.createDetailedNewsVS(
            newsID: newsModel.filteredNews[indexPath.row].id)
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .white
        navigationController?.pushViewController(newsDetailedVC, animated: true)
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
