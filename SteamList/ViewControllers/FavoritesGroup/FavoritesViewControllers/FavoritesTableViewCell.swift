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
        priceLabel.textAlignment = .right
        priceLabel.textColor = .white
        priceLabel.numberOfLines = 1
        return priceLabel
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)

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
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
