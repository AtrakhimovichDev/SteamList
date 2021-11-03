//
//  GameDetails.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 26.10.21.
//

import UIKit

class GameDetailsView: UIView {

    var headerImageView: UIImageView = {
        return UIImageView()
    }()

    var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = Colors.textColor.getUIColor()
        nameLabel.font = UIFont.boldSystemFont(ofSize: 25.0)
        nameLabel.numberOfLines = 2
        nameLabel.textAlignment = .center
        return nameLabel
    }()

    var favButton: UIButton = {
        let favButton = UIButton()
        let config = UIImage.SymbolConfiguration(
            pointSize: 25, weight: .medium, scale: .default)
        let image = UIImage(systemName: "star", withConfiguration: config)
        favButton.setImage(image, for: .normal)
        favButton.tintColor = .orange
        favButton.addTarget(self, action: #selector(favButtonTapped(handler:)), for: .touchUpInside)
        return favButton
    }()

    var genresLabel: UILabel = {
        let genresLabel = UILabel()
        genresLabel.text = "Action    Free to play    Strategy"
        genresLabel.textColor = Colors.additionalTextColor.getUIColor()
        genresLabel.numberOfLines = 1
        genresLabel.textAlignment = .center
        return genresLabel
    }()

    var releaseLabel: UILabel = {
        let releaseLabel = UILabel()
        releaseLabel.text = "9 Jul, 2013"
        releaseLabel.textColor = Colors.additionalTextColor.getUIColor()
        releaseLabel.numberOfLines = 1
        return releaseLabel
    }()

    var priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.text = "Free to play"
        priceLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        priceLabel.textAlignment = .center
        priceLabel.textColor = Colors.discountPricaeColor.getUIColor()
        priceLabel.numberOfLines = 1
        return priceLabel
    }()

    var supportedPlatforms: [UIImageView] = {
        let array = [UIImageView]()
        return array
    }()

    var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        // swiftlint:disable line_length
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = Colors.additionalTextColor.getUIColor()
        descriptionLabel.text = "Every day, millions of players worldwide enter battle as one of over a hundred Dota heroes. And no matter if it's their 10th hour of play or 1,000th, there's always something new to discover. With regular updates that ensure a constant evolution of gameplay, features, and heroes, Dota 2 has taken on a life of its own."
        return descriptionLabel
    }()
//    var screenshotTableView: UITableView!

    private var isFavotite = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }

    convenience init() {
        self.init(frame: UIScreen.main.bounds)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubViews()
    }
    // swiftlint:disable function_body_length
    private func setupSubViews() {
        self.setGradientBackground(firstColor: Colors.firstBackgroundColor.getUIColor(),
                                   secondColor: Colors.secondBackgroundColor.getUIColor())

        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true

        self.addSubview(scrollView)
        scrollView.snp.makeConstraints { constraints in
            constraints.top.bottom.equalTo(safeAreaLayoutGuide)
            constraints.leading.trailing.equalToSuperview()
            constraints.width.equalToSuperview()
        }

        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { constraints in
            constraints.centerX.equalToSuperview()
            constraints.width.equalToSuperview()
            constraints.top.equalToSuperview()
            constraints.height.equalTo(1000)
            constraints.bottom.equalToSuperview()
        }

        contentView.addSubview(headerImageView)
        // headerImageView.translatesAutoresizingMaskIntoConstraints = false
        headerImageView.snp.makeConstraints { constraints in
            constraints.top.equalTo(safeAreaLayoutGuide.snp.top)
            constraints.leading.equalToSuperview()
            constraints.trailing.equalToSuperview()
            constraints.height.greaterThanOrEqualTo(200)
            constraints.height.lessThanOrEqualTo(300)
            // constraints.width.lessThanOrEqualTo(self.bounds.width)
        }

        let containerView = UIView()
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { constraints in
            constraints.top.equalTo(headerImageView.snp.bottomMargin)
            constraints.leading.equalToSuperview()
            constraints.trailing.equalToSuperview()
        }

        let emptyButton = UIButton()
        containerView.addSubview(emptyButton)
        emptyButton.snp.makeConstraints { constraints in
            constraints.top.equalToSuperview().offset(20)
            constraints.leading.equalToSuperview().offset(10)
            constraints.bottom.equalToSuperview().offset(-10)
        }

        containerView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { constraints in
            constraints.leading.equalTo(emptyButton.snp.trailing).offset(10)
            constraints.top.equalToSuperview().offset(20)
            constraints.bottom.equalToSuperview().offset(-10)
        }

        containerView.addSubview(favButton)
        favButton.snp.makeConstraints { constraints in
            constraints.top.equalToSuperview().offset(20)
            constraints.trailing.equalToSuperview().offset(-10)
            constraints.leading.equalTo(nameLabel.snp.trailing).offset(10)
            constraints.bottom.equalToSuperview().offset(-10)
            constraints.width.greaterThanOrEqualTo(30)
            constraints.width.equalTo(emptyButton.snp.width).multipliedBy(1)
        }

        contentView.addSubview(genresLabel)
        genresLabel.snp.makeConstraints { constraints in
            constraints.top.equalTo(containerView.snp.bottom).offset(10)
            constraints.leading.equalToSuperview()
            constraints.trailing.equalToSuperview()
        }

        let nextContainer = UIView()
        contentView.addSubview(nextContainer)
        nextContainer.snp.makeConstraints { constraints in
            constraints.top.equalTo(genresLabel.snp.bottom)
            constraints.leading.equalToSuperview()
            constraints.trailing.equalToSuperview()
        }

        let dateContainer = UIView()
        nextContainer.addSubview(dateContainer)
        dateContainer.snp.makeConstraints { constraints in
            constraints.top.equalToSuperview()
            constraints.leading.equalToSuperview()
            constraints.bottom.equalToSuperview()
        }

        let priceContainer = UIView()
        nextContainer.addSubview(priceContainer)
        priceContainer.snp.makeConstraints { constraints in
            constraints.top.equalToSuperview()
            constraints.leading.equalTo(dateContainer.snp.trailing)
            constraints.bottom.equalToSuperview()
        }

        let platformsContainer = UIView()
        nextContainer.addSubview(platformsContainer)
        platformsContainer.snp.makeConstraints { constraints in
            constraints.top.equalToSuperview()
            constraints.leading.equalTo(priceContainer.snp.trailing)
            constraints.bottom.equalToSuperview()
            constraints.trailing.equalToSuperview()
            constraints.width.equalTo(dateContainer).multipliedBy(1)
            constraints.width.equalTo(priceContainer).multipliedBy(1)
        }

        dateContainer.addSubview(releaseLabel)
        releaseLabel.snp.makeConstraints { constraints in
            constraints.leading.trailing.bottom.equalToSuperview().offset(10)
            constraints.top.equalToSuperview().offset(30)
        }

        priceContainer.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { constraints in
            constraints.leading.trailing.bottom.equalToSuperview().offset(10)
            constraints.top.equalToSuperview().offset(30)
        }
        let image = UIImage(systemName: "applelogo")

        let imageWindows = UIImageView(image: image)
        imageWindows.tintColor = .white
        let imageApple = UIImageView(image: image)
        imageApple.tintColor = .white
        let imageLinux = UIImageView(image: image)
        imageLinux.tintColor = .white

        platformsContainer.addSubview(imageApple)
        platformsContainer.addSubview(imageWindows)
        platformsContainer.addSubview(imageLinux)

        imageLinux.snp.makeConstraints { constraints in
            constraints.top.equalToSuperview().offset(30)
            constraints.bottom.equalToSuperview().offset(10)
            constraints.trailing.equalToSuperview().offset(-10)
            constraints.width.equalTo(imageLinux.snp.height).multipliedBy(0.8)
            constraints.width.equalTo(imageWindows.snp.width)
            constraints.width.equalTo(imageApple.snp.width)
        }

        imageWindows.snp.makeConstraints { constraints in
            constraints.top.equalToSuperview().offset(30)
            constraints.bottom.equalToSuperview().offset(10)
            constraints.trailing.equalTo(imageLinux.snp.leading).offset(-10)
        }

        imageApple.snp.makeConstraints { constraints in
            constraints.top.equalToSuperview().offset(30)
            constraints.bottom.equalToSuperview().offset(10)
            constraints.trailing.equalTo(imageWindows.snp.leading).offset(-10)
        }

        let horizontalLine = UIView()
        horizontalLine.backgroundColor = Colors.additionalTextColor.getUIColor()
        contentView.addSubview(horizontalLine)
        horizontalLine.snp.makeConstraints { constraints in
            constraints.top.equalTo(nextContainer.snp.bottom).offset(30)
            constraints.leading.equalToSuperview().offset(10)
            constraints.trailing.equalToSuperview().offset(-10)
            constraints.height.equalTo(1)
        }

        contentView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.snp.makeConstraints { constraints in
            constraints.top.equalTo(horizontalLine.snp.bottom).offset(30)
            constraints.leading.equalToSuperview().offset(10)
            constraints.trailing.equalToSuperview().offset(-10)
            // constraints.height.equalTo(300)
        }

        let screenshotImage = UIImage(named: "default_game_image")
        let screenshotImageView = UIImageView(image: screenshotImage)
        screenshotImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(screenshotImageView)
        screenshotImageView.snp.makeConstraints { constraints in
            constraints.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            constraints.leading.equalToSuperview().offset(10)
            constraints.trailing.equalToSuperview().offset(-10)
            constraints.height.equalTo(300)
            constraints.bottom.equalToSuperview()
        }
        // scrollView.contentSize.height = CGFloat(1500)
    }

    @objc private func favButtonTapped(handler: UIButton) {
        isFavotite = !isFavotite
        let config = UIImage.SymbolConfiguration(
            pointSize: 25, weight: .medium, scale: .default)
        if isFavotite {
            let image = UIImage(systemName: "star.fill", withConfiguration: config)
            favButton.setImage(image, for: .normal)
        } else {
            let image = UIImage(systemName: "star", withConfiguration: config)
            favButton.setImage(image, for: .normal)
        }
    }
}
