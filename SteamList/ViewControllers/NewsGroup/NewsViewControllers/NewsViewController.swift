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

        customView.filterView.saveButton.addTarget(self, action: #selector(saveFilterSettings), for: .touchUpInside)
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

//        let filterView = FilterView()
//        filterView.layer.borderWidth = 1
//        filterView.layer.borderColor = Colors.additionalTextColor.getUIColor().cgColor
//        filterView.center = customView.center
//        filterView.frame.size = CGSize(width: customView.frame.width * 0.6, height: customView.frame.height * 0.5)
//        filterView.setGradientBackground(firstColor: Colors.firstBackgroundColor.getUIColor(),
//                                                                            secondColor: Colors.secondBackgroundColor.getUIColor())
//        customView.addSubview(filterView)
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
