//
//  NewsViewController.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 25.10.21.
//

import UIKit

class NewsViewController: UIViewController {

    private var customView = NewsView()
    private var newsModel: NewsModel!

    override func loadView() {
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        var newsArray = [NewsItem]()
        newsArray.append(NewsItem(title: "Best PC games of 2020",
                                  gameName: "CS: GO",
                                  author: "Numantian games",
                                  date: Date(),
                                  contents: ""))
        newsArray.append(NewsItem(title: "Tournament winner!",
                                  gameName: "CS: GO",
                                  author: "Allow games",
                                  date: Date(),
                                  contents: ""))
        newsArray.append(NewsItem(title: "New antimage strategy",
                                  gameName: "Dota 2",
                                  author: "Valve",
                                  date: Date(),
                                  contents: ""))
        newsModel = NewsModel(dataStatus: .success, news: newsArray)
        let rightBarItem = UIBarButtonItem(title: "Filter",
                                           style: .plain,
                                           target: self,
                                           action: #selector(filterButtonPressed))
        rightBarItem.tintColor = .white
        navigationItem.rightBarButtonItem = rightBarItem

        customView.tableView.delegate = self
        customView.tableView.dataSource = self

        customView.tableView.reloadData()
    }

    @objc
    private func filterButtonPressed() {

    }
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsModel.news.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: NewsTableViewCell.identifier,
                for: indexPath) as? NewsTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.titleLabel.text = newsModel.news[indexPath.row].title
        cell.authorLabel.text = "by \(newsModel.news[indexPath.row].author)"
        cell.gameNameLabel.text = newsModel.news[indexPath.row].gameName
        cell.dateLabel.text = CustomDateFormater.shared.getString(from: newsModel.news[indexPath.row].date)
        return cell
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
