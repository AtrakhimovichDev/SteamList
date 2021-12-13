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
    case linkColor = "#7584B6"
    case buttonColor = "#2A5788"

    func getUIColor() -> UIColor {
        #colorLiteral(red: 0.1647058824, green: 0.3411764706, blue: 0.5333333333, alpha: 1)
        return UIColor(hex: self.rawValue)
    }
}
