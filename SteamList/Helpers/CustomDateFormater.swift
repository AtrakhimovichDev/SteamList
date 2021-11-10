//
//  CustomDateFormater.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 10.11.21.
//

import Foundation

class CustomDateFormater {
    
    static var shared = CustomDateFormater()
    
    func getString(from date: Date) -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "d MMM, yyyy"
        let date = dateFormater.string(from: date)
        return date
    }
}
