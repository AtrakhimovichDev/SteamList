//
//  FavoritesTableViewCell.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 9.11.21.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {

    static let identifier = "FavoritesTableViewCell"

    var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = Colors.additionalTextColor.getUIColor()
        titleLabel.numberOfLines = 0
        return titleLabel
    }()

    var priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        priceLabel.textAlignment = .right
        priceLabel.textColor = .white
        priceLabel.numberOfLines = 1
        return priceLabel
    }()

    var activityIndicator: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView()
        indicatorView.color = .white
        return indicatorView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear

        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        priceLabel.addSubview(activityIndicator)

        titleLabel.snp.makeConstraints { (constraints) in
            constraints.top.equalToSuperview().offset(10)
            constraints.centerY.equalToSuperview()
            constraints.leading.equalToSuperview().offset(15)
        }

        priceLabel.snp.makeConstraints { (constraints) in
            constraints.top.equalToSuperview().offset(10)
            constraints.centerY.equalTo(contentView)
            constraints.trailing.equalTo(contentView).offset(-15)
            constraints.leading.equalTo(titleLabel.snp.trailing).offset(10)
            constraints.width.equalTo(titleLabel.snp.width).multipliedBy(0.75)
        }

        activityIndicator.snp.makeConstraints { constraints in
            constraints.top.equalToSuperview().offset(5)
            constraints.bottom.equalToSuperview().offset(-5)
            constraints.trailing.equalToSuperview().offset(-5)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
