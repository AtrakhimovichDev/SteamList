//
//  GameDetailedInfo+CoreDataProperties.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 7.11.21.
//
//

import Foundation
import CoreData

extension GameDetailedInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GameDetailedInfo> {
        return NSFetchRequest<GameDetailedInfo>(entityName: "GameDetailedInfo")
    }

    @NSManaged public var gameID: String
    @NSManaged public var name: String
    @NSManaged public var gameDescription: String
    @NSManaged public var headerImageURL: String?
    @NSManaged public var isApple: Bool
    @NSManaged public var isLinux: Bool
    @NSManaged public var isWindows: Bool
    @NSManaged public var isCoomingSoon: Bool
    @NSManaged public var releaseDate: Date?
    @NSManaged public var isFree: Bool
    @NSManaged public var price: Float
    @NSManaged public var priceTitle: String?
    @NSManaged public var discont: Int16
    @NSManaged public var attribute: Int16
    @NSManaged public var genres: [String]?
    @NSManaged public var screensotsURL: [String]?

}

extension GameDetailedInfo: Identifiable {
}
