//
//  AddTimeVC.swift
//  Circle
//
//  Created by Sharvil Kekre on 1/2/22.
//

import UIKit
import SwiftUI
import Firebase

class AddTimeVC: UIViewController {
    
    let logger = CircleLogger()
    
    private var authUser : User? {
        return Auth.auth().currentUser
    }
    
    private let addButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .capsule
        configuration.baseForegroundColor = UIColor.white
        configuration.baseBackgroundColor = UIColor.systemOrange
        configuration.buttonSize = .large
        configuration.title = "Add"

        let button = UIButton(configuration: configuration, primaryAction: nil)
        return button
    }()
    
    private let cancelButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .capsule
        configuration.baseForegroundColor = UIColor.white
        configuration.baseBackgroundColor = UIColor(red: 204/255, green: 0, blue: 0, alpha: 1)
        configuration.buttonSize = .large
        configuration.title = "Cancel"

        let button = UIButton(configuration: configuration, primaryAction: nil)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        ViewUtils().addGradientOne(controller: self)
        
        view.addSubview(addButton)
        addButton.addTarget(self, action: #selector(addPressed), for: .touchUpInside)
        view.addSubview(cancelButton)
        cancelButton.addTarget(self, action: #selector(cancelPressed), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        addButton.frame = CGRect(
            x: 50,
            y: view.frame.size.height-150-view.safeAreaInsets.bottom,
            width: view.frame.width-100,
            height: 50
        )
        
        cancelButton.frame = CGRect(
            x: 50,
            y: view.frame.size.height-75-view.safeAreaInsets.bottom,
            width: view.frame.width-100,
            height: 50
        )
    }
    
    @objc func addPressed() {
        self.logger.info(msg: "add pressed")
    }
    
    @objc func cancelPressed() {
        self.performSegue(withIdentifier: "returnTime", sender: self)
    }
}
