//
//  GameItem+CoreDataProperties.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 1.11.21.
//
//

import Foundation
import CoreData

extension GameItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GameItem> {
        return NSFetchRequest<GameItem>(entityName: "GameItem")
    }

    @NSManaged public var gameID: String
    @NSManaged public var name: String

}
