//
//  DetailedNewsViewController.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 24.11.21.
//

import UIKit

class DetailedNewsViewController: UIViewController {

    var newsID: String!

    private let customView = DetailedNewsView()
    private var newsModel: DetailedNewsModel!

    override func loadView() {
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    private func loadData() {
        ModelsFactory.shared.createDetailedNewsModel(newsID: newsID) { [weak self] detailedNewsModel in
            self?.newsModel = detailedNewsModel
            DispatchQueue.main.async {
                guard let status = self?.newsModel.dataStatus else { return }
                self?.customView.setupView(with: status)
                self?.updateView()
            }
        }
    }

    private func updateView() {
        guard newsModel.dataStatus == .success,
            let newsInfo = newsModel.news else {
            return
        }
        customView.authorLabel.text = "by \(newsInfo.author)"
        customView.dateLabel.text = CustomDateFormater.shared.getString(from: newsInfo.date)
        customView.titleLabel.text = newsInfo.title
        customView.gameNameLabel.text = newsInfo.gameName
        let font = UIFont.systemFont(ofSize: 40)
        let fontName =  "-apple-system"
        let linkStyle = "<style>a:link { color: \(Colors.linkColor.rawValue); }</style>"
        let htmlString = "\(linkStyle)<span style=\"font-family: \(fontName); font-size: \(font.pointSize); color: #FFFFFF\">\(newsInfo.contents)</span>"
        customView.webView.loadHTMLString(htmlString, baseURL: nil)
    }
}
