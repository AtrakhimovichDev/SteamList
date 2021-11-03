//
//  Colors.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 25.10.21.
//

import UIKit

enum Colors: String {
    case navBarColor = "#3E6382"
    case firstBackgroundColor = "#223C53"
    case secondBackgroundColor = "#1E293A"
    case textColor = "#ffffff"
    case additionalTextColor = "#D2D6D9"
    case discountPricaeColor = "#7DA934"

    func getUIColor() -> UIColor {
        return UIColor(hex: self.rawValue)
    }
}
