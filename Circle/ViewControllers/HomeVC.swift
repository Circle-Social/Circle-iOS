//
//  HomeVC.swift
//  Circle
//
//  Created by Sharvil Kekre on 1/2/22.
//

import UIKit
import SwiftUI
import Firebase

class HomeViewController: UIViewController {
    
    private var authUser : User? {
        return Auth.auth().currentUser
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addGradient()
        let tc = TimeClient()
        tc.getFreeTime(uid: authUser!.uid) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let value):
                for entry in value {
                    print("Start: \(String(describing: entry!["startDate"]!))")
                    print("End: \(String(describing: entry!["endDate"]!))")
                }
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    @IBAction func addTime(_ sender: Any) {
        
    }

    func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [
            UIColor.white.cgColor,
            UIColor.orange.cgColor
        ]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
}
