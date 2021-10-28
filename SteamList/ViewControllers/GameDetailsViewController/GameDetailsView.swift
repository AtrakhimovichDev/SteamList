//
//  GameDetails.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 26.10.21.
//

import UIKit

class GameDetailsView: UIView {

    var headerImage: UIImageView!
    var nameLabel: UILabel!
//    var favButton: UIButton!
//    var genresLabels: [UILabel]!
//    var releaseLabel: UILabel!
//    var priceLabel: UILabel!
//    var supportedPlatforms: [UIImageView]!
//    var descrirtion: UITextField!
//    var screenshotTableView: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createSubViews()
    }

    private func createSubViews() {
        headerImage = UIImageView()
        self.addSubview(headerImage)
        headerImage.snp.makeConstraints { constraints in
            constraints.top.equalToSuperview()
            constraints.leading.equalToSuperview()
            constraints.trailing.equalToSuperview()
            constraints.height.lessThanOrEqualTo(300)
        }
        nameLabel = UILabel()
        nameLabel.textColor = .white
        nameLabel.font = UIFont.boldSystemFont(ofSize: 25.0)
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .center
        self.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { constraints in
            constraints.leading.equalToSuperview().offset(30)
            constraints.trailing.equalToSuperview().offset(-30)
            // constraints.centerX.equalToSuperview()
            constraints.top.equalTo(headerImage.snp.bottomMargin).offset(20)
        }
    }

}
