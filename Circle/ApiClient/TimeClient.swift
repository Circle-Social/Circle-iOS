//
//  TimeClient.swift
//  Circle
//
//  Created by Sharvil Kekre on 1/2/22.
//

import Foundation
import Alamofire


class TimeClient: NSObject {
    
    let timeEndpoint = "https://circle-social.net/time"
    
    func getFreeTime(uid: String, completionHandler: @escaping (Result<[AnyObject?], AFError>) -> Void) {
        let freeTimeEndpoint = "\(timeEndpoint)/grab_free_time.php"
        let parameters: [String: Any] = [
            "uid" : uid
        ]
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        print("parameters: \(parameters)")
        
        AF.request(freeTimeEndpoint, method: .post, parameters: parameters, headers: headers)
            .validate()
            .responseString { response in
                switch (response.result) {
                case .success( _):
                do {
                    let freeSlots = ApiUtils().convertToDictionary(text: response.value!) as? [AnyObject]
                    completionHandler(.success(freeSlots!))
                }
                case .failure(let error):
                    print("Request error: \(error.localizedDescription)")
                    completionHandler(.failure(error))
                }
            }
    }
}
