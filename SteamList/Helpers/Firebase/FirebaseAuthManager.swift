//
//  FirebaseAuthManager.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 13.12.21.
//

import Foundation
import FirebaseAuth

class FirebaseAuthManager: FBAuth {

    func createUser(email: String, password: String, completion: @escaping ((Bool) -> Void)) {
        Auth.auth().createUser(withEmail: email, password: password) {(authResult, error) in
            if let user = authResult?.user {
                print(user)
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}
