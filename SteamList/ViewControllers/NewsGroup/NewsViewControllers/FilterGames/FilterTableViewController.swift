//
//  FilterTableViewController.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 22.11.21.
//

import UIKit

class FilterTableViewController: NSObject, UITableViewDataSource, UITableViewDelegate {

    var newsModel: NewsModel?

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsModel?.filteredGames.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell =
                tableView.dequeueReusableCell(
                    withIdentifier: FilterTableViewCell.identifier) as? FilterTableViewCell,
              let newsModel = newsModel else {
            return UITableViewCell()
        }
        let info = newsModel.filteredGames[indexPath.row]
        cell.titleLabel.text = info.name
        cell.checkmarkImageView.isHidden = !info.isEnabled
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let newsModel = newsModel else { return }
        newsModel.filteredGames[indexPath.row].isEnabled.toggle()
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
