//
//  UserClient.swift
//  Circle
//
//  Created by Sharvil Kekre on 1/2/22.
//

import Foundation
import Alamofire


class UserClient: NSObject {
    
    var email: String?
    var displayName: String?
    var uid: String?
    
    let userEndpoint = "https://circle-social.net/users"
    
    //construct with @email, @displayName, @uid parameters
    init(email: String, displayName: String, uid: String) {
        self.email = email
        self.displayName = displayName
        self.uid = uid
    }
    
    
    //prints object's current state
    override var description: String {
        return "Email: \(email ?? "mock@email.com"), displayName: \(displayName ?? "mockName")"
    }
    
    
    func create(){
        let createUserEndpoint = "\(userEndpoint)/create_user.php"
        let parameters: [String: Any] = [
            "email" : self.email!,
            "displayname" : self.displayName!
        ]
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        AF.request(createUserEndpoint, method: .post, parameters: parameters, headers: headers)
            .response { response in
                print(response.result)
            }
    }
}
