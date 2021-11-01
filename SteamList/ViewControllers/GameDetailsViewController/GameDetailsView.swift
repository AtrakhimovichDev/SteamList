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
    var favButton: UIButton!
//    var genresLabels: [UILabel]!
//    var releaseLabel: UILabel!
//    var priceLabel: UILabel!
//    var supportedPlatforms: [UIImageView]!
//    var descrirtion: UITextField!
//    var screenshotTableView: UITableView!

    private var isFavotite = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubViews()
    }

    convenience init() {
        self.init(frame: UIScreen.main.bounds)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createSubViews()
    }

    private func createSubViews() {
        self.setGradientBackground(firstColor: Colors.firstBackgroundColor.getUIColor(),
                                   secondColor: Colors.secondBackgroundColor.getUIColor())
        headerImage = UIImageView()
        self.addSubview(headerImage)

        headerImage.snp.makeConstraints { constraints in
            constraints.top.equalToSuperview().offset(90)
            constraints.leading.equalToSuperview()
            constraints.trailing.equalToSuperview()
            constraints.height.lessThanOrEqualTo(300)
        }

        let containerView = UIView()
        self.addSubview(containerView)
        containerView.snp.makeConstraints { constraints in
            constraints.top.equalTo(headerImage.snp.bottomMargin)
            constraints.leading.equalToSuperview()
            constraints.trailing.equalToSuperview()
        }

        nameLabel = UILabel()
        nameLabel.textColor = .white
        nameLabel.font = UIFont.boldSystemFont(ofSize: 25.0)
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .center
        containerView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { constraints in
            constraints.leading.equalToSuperview().offset(40)
            // constraints.trailing.equalToSuperview().offset(-30)
            // constraints.centerX.equalToSuperview()
            constraints.top.equalToSuperview().offset(20)
            constraints.bottom.equalToSuperview().offset(40)
        }

        favButton = UIButton()
        favButton.setImage(UIImage(systemName: "star"), for: .normal)
        favButton.tintColor = .orange
        favButton.addTarget(self, action: #selector(favButtonTapped(handler:)), for: .touchUpInside)
        containerView.addSubview(favButton)
        favButton.snp.makeConstraints { constraints in
            constraints.top.equalToSuperview().offset(20)
            constraints.trailing.equalToSuperview().offset(-20)
            constraints.leading.equalTo(nameLabel.snp.trailing).offset(10)
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
}
