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

    func getDate(from dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "d LLL. yyyy"
        if let date = dateFormatter.date(from: dateString) {
            return date
        }
        return Date()
    }
}
