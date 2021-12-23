//
//  NewsDetailedInfo+CoreDataProperties.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 24.11.21.
//
//

import Foundation
import CoreData

extension NewsDetailedInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewsDetailedInfo> {
        return NSFetchRequest<NewsDetailedInfo>(entityName: "NewsDetailedInfo")
    }

    @NSManaged public var gameID: String
    @NSManaged public var title: String
    @NSManaged public var gameName: String
    @NSManaged public var author: String
    @NSManaged public var date: Date
    @NSManaged public var contents: String
    @NSManaged public var newsID: String

}

extension NewsDetailedInfo: Identifiable {

}
