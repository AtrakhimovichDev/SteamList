//
//  Colors.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 25.10.21.
//

import UIKit

enum Colors: String {
    case navBarColor = "#3E6382"
    case backgroundColor = "#223C53"
    case textColor = "#ffffff"
    
    func getUIColor() -> UIColor {
        return UIColor(hex: self.rawValue)
    }
}
