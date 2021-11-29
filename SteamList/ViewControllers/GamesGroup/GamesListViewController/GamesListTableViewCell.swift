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

    private var isFavotite = false

    var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)
        return label
    }()

    var favButton: UIButton = FavoriteButton()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .clear
        setupTitleLabel()
        setupFavButton()
    }

    private func setupTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (constraints) in
            constraints.top.equalToSuperview().offset(10)
            constraints.centerY.equalToSuperview()
            constraints.leading.equalToSuperview().offset(15)
        }
    }

    private func setupFavButton() {
        contentView.addSubview(favButton)
        favButton.snp.makeConstraints { (constraints) in
            constraints.top.equalToSuperview().offset(10)
            constraints.centerY.equalTo(contentView)
            constraints.trailing.equalTo(contentView).offset(-15)
            constraints.leading.greaterThanOrEqualTo(titleLabel.snp.trailing).offset(10)
            constraints.width.greaterThanOrEqualTo(20)
        }
    }

    func setup(gameItem: GamesListItem, index: Int) {
        self.selectionStyle = .none
        favButton.tag = index
        if let button = favButton as? FavoriteButton {
            button.setIcon(isFavorite: gameItem.isFavorite)
        }
        titleLabel.text = gameItem.name
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
