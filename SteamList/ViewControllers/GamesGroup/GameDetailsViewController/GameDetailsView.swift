//
//  GameDetails.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 26.10.21.
//

import UIKit

class GameDetailsView: UIView {

    var tappedScreenshotCompletion: ((UIImage) -> Void)!

    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true
        return scrollView
    }()

    var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()

    var gameNameContainerView = UIView()
    let additionalInfoContainer = UIView()
    var headerImageView = UIImageView()

    var imageViewActivityIndicator: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView(style: .large)
        indicatorView.color = .white
        return indicatorView
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
        let favButton = FavoriteButton()
        let config = UIImage.SymbolConfiguration(
            pointSize: 25, weight: .medium, scale: .default)
        let image = UIImage(systemName: "star", withConfiguration: config)
        favButton.setImage(image, for: .normal)
        return favButton
    }()

    var genresLabel: UILabel = {
        let genresLabel = UILabel()
        genresLabel.textColor = Colors.additionalTextColor.getUIColor()
        genresLabel.numberOfLines = 0
        genresLabel.textAlignment = .center
        return genresLabel
    }()

    var releaseLabel: UILabel = {
        let releaseLabel = UILabel()
        releaseLabel.textColor = Colors.additionalTextColor.getUIColor()
        releaseLabel.numberOfLines = 1
        return releaseLabel
    }()

    var priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        priceLabel.textAlignment = .center
        priceLabel.textColor = Colors.discountPricaeColor.getUIColor()
        priceLabel.numberOfLines = 1
        return priceLabel
    }()

    var discontLabel: UILabel = {
        let discontLabel = UILabel()
        discontLabel.textAlignment = .center
        discontLabel.textColor = Colors.discountPricaeColor.getUIColor()
        discontLabel.numberOfLines = 1
        return discontLabel
    }()

    var imageViewApple: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "apple_icon"))
        return imageView
    }()

    var imageViewWindows: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "windows_icon"))
        return imageView
    }()

    var imageViewLinux: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "linux_icon"))
        return imageView
    }()

    var horizontalLine: UIView = {
        let horizontalLine = UIView()
        horizontalLine.backgroundColor = Colors.additionalTextColor.getUIColor()
        return horizontalLine
    }()

    var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = Colors.additionalTextColor.getUIColor()
        return descriptionLabel
    }()

    private var errorLabel: UILabel = {
        let errorLabel = UILabel()
        errorLabel.textColor = .white
        return errorLabel
    }()

    var screenshotsViews = [UIImageView]()

    private var isFavotite = false
    private var lastImageView: UIImageView?

    override init(frame: CGRect) {
        super.init(frame: frame)
        startSettings()
    }

    convenience init() {
        self.init(frame: UIScreen.main.bounds)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        startSettings()
    }

    func setupView(with dataStatus: DataStatus) {
        switch dataStatus {
        case .success:
            setupSeccessView()
        case .empty:
            setupEmptyView()
        case .error:
            setupErrorView()
        }
    }

    private func setupSeccessView() {
        setupScrollView()
        setupContentView()
        setupHeaderImageView()
        setupGameNameContainer()
        setupGenresLabel()
        setupAdditionalInfoContainer()
        setupHorizontalLine()
        setupDescriptionLabel()
    }

    private func setupEmptyView() {
        setupErrorLabel(text: "Oops... No data here")
    }

    private func setupErrorView() {
        setupErrorLabel(text: "Oops... Something go wrong")
    }

    private func startSettings() {
        self.setGradientBackground(firstColor: Colors.firstBackgroundColor.getUIColor(),
                                   secondColor: Colors.secondBackgroundColor.getUIColor())
    }

    private func setupScrollView() {
        self.addSubview(scrollView)
        scrollView.snp.makeConstraints { constraints in
            constraints.top.bottom.equalTo(safeAreaLayoutGuide)
            constraints.leading.trailing.equalToSuperview()
            constraints.width.equalToSuperview()
        }
    }

    private func setupContentView() {
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { constraints in
            constraints.centerX.width.top.bottom.equalToSuperview()
        }
    }

    private func setupHeaderImageView() {
        contentView.addSubview(headerImageView)
        headerImageView.snp.makeConstraints { constraints in
            constraints.top.leading.trailing.equalToSuperview()
            constraints.height.equalTo(contentView.snp.width).multipliedBy(0.5)
        }

        headerImageView.addSubview(imageViewActivityIndicator)
        imageViewActivityIndicator.snp.makeConstraints { constraints in
            constraints.center.equalToSuperview()
        }
    }

    private func setupGameNameContainer() {
        contentView.addSubview(gameNameContainerView)
        gameNameContainerView.snp.makeConstraints { constraints in
            constraints.top.equalTo(headerImageView.snp.bottomMargin)
            constraints.leading.trailing.equalToSuperview()
        }

        let emptyButton = UIButton()
        gameNameContainerView.addSubview(emptyButton)
        emptyButton.snp.makeConstraints { constraints in
            constraints.top.equalToSuperview().offset(20)
            constraints.leading.equalToSuperview().offset(10)
            constraints.bottom.equalToSuperview().offset(-10)
        }

        gameNameContainerView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { constraints in
            constraints.leading.equalTo(emptyButton.snp.trailing).offset(10)
            constraints.top.equalToSuperview().offset(20)
            constraints.bottom.equalToSuperview().offset(-10)
        }

        gameNameContainerView.addSubview(favButton)
        favButton.snp.makeConstraints { constraints in
            constraints.top.equalToSuperview().offset(20)
            constraints.trailing.equalToSuperview().offset(-10)
            constraints.leading.equalTo(nameLabel.snp.trailing).offset(10)
            constraints.bottom.equalToSuperview().offset(-10)
            constraints.width.greaterThanOrEqualTo(30)
            constraints.width.equalTo(emptyButton.snp.width).multipliedBy(1)
        }
    }

    private func setupGenresLabel() {
        contentView.addSubview(genresLabel)
        genresLabel.snp.makeConstraints { constraints in
            constraints.top.equalTo(gameNameContainerView.snp.bottom).offset(10)
            constraints.leading.equalToSuperview().offset(10)
            constraints.trailing.equalToSuperview().offset(-10)
        }
    }

    private func setupAdditionalInfoContainer() {
        contentView.addSubview(additionalInfoContainer)
        additionalInfoContainer.snp.makeConstraints { constraints in
            constraints.top.equalTo(genresLabel.snp.bottom)
            constraints.leading.trailing.equalToSuperview()
        }

        let dateContainer = UIView()
        additionalInfoContainer.addSubview(dateContainer)
        dateContainer.snp.makeConstraints { constraints in
            constraints.top.leading.bottom.equalToSuperview()
        }

        let priceContainer = UIView()
        additionalInfoContainer.addSubview(priceContainer)
        priceContainer.snp.makeConstraints { constraints in
            constraints.top.bottom.equalToSuperview()
            constraints.leading.equalTo(dateContainer.snp.trailing)
        }

        let platformsContainer = UIView()
        additionalInfoContainer.addSubview(platformsContainer)
        platformsContainer.snp.makeConstraints { constraints in
            constraints.top.bottom.trailing.equalToSuperview()
            constraints.leading.equalTo(priceContainer.snp.trailing)
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

        platformsContainer.addSubview(imageViewApple)
        platformsContainer.addSubview(imageViewWindows)
        platformsContainer.addSubview(imageViewLinux)

        imageViewWindows.snp.makeConstraints { constraints in
            constraints.top.equalToSuperview().offset(30)
            constraints.bottom.equalToSuperview().offset(10)
            constraints.trailing.equalToSuperview().offset(-10)
            constraints.width.equalTo(imageViewWindows.snp.height).multipliedBy(1)
            constraints.width.equalTo(imageViewLinux.snp.width)
            constraints.width.equalTo(imageViewApple.snp.width)
        }

        imageViewApple.snp.makeConstraints { constraints in
            constraints.top.equalToSuperview().offset(30)
            constraints.bottom.equalToSuperview().offset(10)
            constraints.trailing.equalTo(imageViewWindows.snp.leading).offset(-10)
        }

        imageViewLinux.snp.makeConstraints { constraints in
            constraints.top.equalToSuperview().offset(30)
            constraints.bottom.equalToSuperview().offset(10)
            constraints.trailing.equalTo(imageViewApple.snp.leading).offset(-10)
        }

        gameNameContainerView.addSubview(discontLabel)
        discontLabel.snp.makeConstraints { constraints in
            constraints.top.equalTo(additionalInfoContainer.snp.bottom).offset(10)
            constraints.leading.equalToSuperview().offset(10)
            constraints.trailing.equalToSuperview().offset(-10)
        }
    }

    private func setupHorizontalLine() {
        contentView.addSubview(horizontalLine)
        horizontalLine.snp.makeConstraints { constraints in
            constraints.top.equalTo(discontLabel.snp.bottom).offset(30)
            constraints.leading.equalToSuperview().offset(10)
            constraints.trailing.equalToSuperview().offset(-10)
            constraints.height.equalTo(1)
        }
    }

    private func setupDescriptionLabel() {
        contentView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.snp.makeConstraints { constraints in
            constraints.top.equalTo(horizontalLine.snp.bottom).offset(20)
            constraints.leading.equalToSuperview().offset(10)
            constraints.trailing.equalToSuperview().offset(-10)
        }
    }

    private func setupErrorLabel(text: String) {
        self.addSubview(errorLabel)
        errorLabel.text = text
        errorLabel.snp.makeConstraints { constraints in
            constraints.center.equalToSuperview()
        }
    }

    func createScreenShotImageViews(numbers: Int) {
        for count in 0..<numbers {
            let screenshotImageView = UIImageView()
            screenshotImageView.translatesAutoresizingMaskIntoConstraints = false
            screenshotImageView.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedScreenshot(handler:)))
            screenshotImageView.addGestureRecognizer(tapGesture)
            screenshotsViews.append(screenshotImageView)
            contentView.addSubview(screenshotImageView)
            screenshotImageView.snp.makeConstraints { constraints in
                if let lastImageView = lastImageView {
                    constraints.top.equalTo(lastImageView.snp.bottom).offset(5)
                } else {
                    constraints.top.equalTo(descriptionLabel.snp.bottom).offset(20)
                }
                constraints.leading.equalToSuperview().offset(10)
                constraints.trailing.equalToSuperview().offset(-10)
                constraints.height.equalTo(contentView.snp.width).multipliedBy(0.5)
                if count == numbers - 1 {
                    constraints.bottom.equalToSuperview()
                }
            }
            lastImageView = screenshotImageView
        }
    }

    @objc private func tappedScreenshot(handler: UITapGestureRecognizer) {
        if let imageView = handler.view as? UIImageView,
           let image = imageView.image {
            tappedScreenshotCompletion(image)
        }
    }
}
