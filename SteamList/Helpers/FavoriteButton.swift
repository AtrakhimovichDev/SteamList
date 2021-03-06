//
//  FavoriteButton.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 11.11.21.
//

import UIKit

class FavoriteButton: UIButton {

    init() {
        super.init(frame: .zero)
        self.setImage(UIImage(systemName: "star"), for: .normal)
        self.tintColor = .orange
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setIcon(isFavorite: Bool, config: UIImage.SymbolConfiguration? = nil) {
        if isFavorite {
            let image = UIImage(systemName: "star.fill", withConfiguration: config)
            self.setImage(image, for: .normal)
        } else {
            let image = UIImage(systemName: "star", withConfiguration: config)
            self.setImage(image, for: .normal)
        }
    }
}
