//
//  ApiUtils.swift
//  Circle
//
//  Created by Sharvil Kekre on 1/2/22.
//

import Foundation


class ApiUtils: NSObject {
    
    func convertToDictionary(text: String) -> Any? {
         if let data = text.data(using: .utf8) {
             do {
                 return try JSONSerialization.jsonObject(with: data, options: [])
             } catch {
                 print(error.localizedDescription)
             }
         }

         return nil
    }
}
