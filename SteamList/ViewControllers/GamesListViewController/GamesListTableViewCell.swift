//
//  GamesListTableViewCell.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 25.10.21.
//

import UIKit
import SnapKit

class GamesListTableViewCell: UITableViewCell {

    static let identifier = "GamesListTableViewCell"

    var titleLabel: UILabel!
    var favButton: UIButton!
    var isFavotite = false

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        titleLabel = UILabel()
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        titleLabel.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)

        favButton = UIButton()
        favButton.setImage(UIImage(systemName: "star"), for: .normal)
        favButton.tintColor = .orange
        favButton.addTarget(self, action: #selector(favButtonTapped(handler:)), for: .touchUpInside)
        contentView.addSubview(titleLabel)
        contentView.addSubview(favButton)

        titleLabel.snp.makeConstraints { (constraints) in
            constraints.top.equalToSuperview().offset(10)
            constraints.centerY.equalToSuperview()
            constraints.leading.equalToSuperview().offset(15)
        }

        favButton.snp.makeConstraints { (constraints) in
            constraints.top.equalToSuperview().offset(10)
            constraints.centerY.equalTo(contentView)
            constraints.trailing.equalTo(contentView).offset(-15)
            constraints.leading.greaterThanOrEqualTo(titleLabel.snp.trailing).offset(10)
            constraints.width.greaterThanOrEqualTo(20)
        }
    }

    @objc private func favButtonTapped(handler: UIButton) {
        isFavotite = !isFavotite
        if isFavotite {
            favButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            favButton.setImage(UIImage(systemName: "star"), for: .normal)
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
