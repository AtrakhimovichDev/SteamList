//
//  FBAuth.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 13.12.21.
//

import Foundation

protocol FBAuth {
    func createUser(email: String, password: String, completion: @escaping ((_ error: String?) -> Void))
    func signIn(email: String, password: String, completionBlock: @escaping (_ error: String?) -> Void)
}
