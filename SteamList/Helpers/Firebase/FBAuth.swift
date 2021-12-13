//
//  FBAuth.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 13.12.21.
//

import Foundation

protocol FBAuth {
    func createUser(email: String, password: String, completion: @escaping ((_ success: Bool) -> Void))
}
