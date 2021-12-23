//
//  FirebaseAuthManager.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 13.12.21.
//

import Foundation
import FirebaseAuth

class FirebaseAuthManager: FBAuth {

    func createUser(email: String, password: String, completion: @escaping ((_ error: String?) -> Void)) {
        Auth.auth().createUser(withEmail: email, password: password) {(authResult, error) in
            if let user = authResult?.user {
                print(user)
                completion(nil)
            } else {
                completion(error?.localizedDescription)
            }
        }
    }

    func signIn(email: String, password: String, completionBlock: @escaping (_ error: String?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (_, error) in
            if let error = error, let _ = AuthErrorCode(rawValue: error._code) {
                completionBlock(error.localizedDescription)
            } else {
                completionBlock(nil)
            }
        }
    }
}
