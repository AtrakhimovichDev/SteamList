//
//  NewsTableViewCell.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 10.11.21.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    static let identifier = "NewsTableViewCell"

    var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        label.numberOfLines = 0
        return label
    }()

    var gameNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .left
        label.textColor = Colors.additionalTextColor.getUIColor()
        label.numberOfLines = 1
        return label
    }()

    var authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 12)
        label.textAlignment = .left
        label.textColor = Colors.additionalTextColor.getUIColor()
        label.numberOfLines = 1
        return label
    }()

    var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .right
        label.textColor = Colors.additionalTextColor.getUIColor()
        label.numberOfLines = 1
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear

        let containerView = UIView()
        containerView.addSubview(gameNameLabel)
        containerView.addSubview(dateLabel)

        contentView.addSubview(containerView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(authorLabel)

        containerView.snp.makeConstraints { constraints in
            constraints.top.leading.trailing.equalToSuperview()
        }

        gameNameLabel.snp.makeConstraints { (constraints) in
            constraints.top.equalToSuperview().offset(10)
            constraints.centerY.equalToSuperview()
            constraints.leading.equalToSuperview().offset(15)
        }

        dateLabel.snp.makeConstraints { constraints in
            constraints.top.equalToSuperview().offset(10)
            constraints.centerY.equalToSuperview()
            constraints.trailing.equalToSuperview().offset(-10)
            constraints.leading.equalTo(gameNameLabel.snp.trailing).offset(10)
            constraints.width.equalTo(gameNameLabel.snp.width).multipliedBy(0.5)
        }

        authorLabel.snp.makeConstraints { (constraints) in
            constraints.top.equalTo(containerView.snp.bottom)
            constraints.trailing.equalToSuperview().offset(-10)
            constraints.leading.equalToSuperview().offset(15)
        }

        titleLabel.snp.makeConstraints { constraints in
            constraints.top.equalTo(authorLabel.snp.bottom).offset(10)
            constraints.trailing.equalToSuperview().offset(-10)
            constraints.leading.equalToSuperview().offset(15)
            constraints.bottom.equalToSuperview().offset(-10)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func fillInfo(info: NewsItem) {
        self.titleLabel.text = info.title
        self.authorLabel.text = "by \(info.author.isEmpty ? "Unknown" : info.author)"
        self.gameNameLabel.text = info.gameName
        self.dateLabel.text = CustomDateFormater.shared.getString(from: info.date)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
