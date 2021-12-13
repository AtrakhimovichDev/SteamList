//
//  RealtimeDatabaseManager.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 10.12.21.
//

import Foundation
import FirebaseDatabase

class RealtimeDatabaseManager {
    
    var ref = Database.database().reference(withPath: "grocery-items")
}
