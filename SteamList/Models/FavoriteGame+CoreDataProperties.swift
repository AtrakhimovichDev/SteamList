//
//  FavoriteGame+CoreDataProperties.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 11.11.21.
//
//

import Foundation
import CoreData


extension FavoriteGame {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteGame> {
        return NSFetchRequest<FavoriteGame>(entityName: "FavoriteGame")
    }

    @NSManaged public var gameID: String?
    @NSManaged public var name: String?
    @NSManaged public var price: Double
    @NSManaged public var priceTitle: String?
    @NSManaged public var discont: Int16

}

extension FavoriteGame : Identifiable {

}
