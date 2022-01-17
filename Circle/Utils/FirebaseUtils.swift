//
//  FirebaseUtils.swift
//  Circle
//
//  Created by Sharvil Kekre on 1/16/22.
//

import Foundation
import Firebase


class FirebaseUtils: NSObject {
    
    func logOutUser() {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print("Error: \(signOutError)")
        }
    }
}
