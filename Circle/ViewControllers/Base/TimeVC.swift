//
//  TimeVC.swift
//  Circle
//
//  Created by Sharvil Kekre on 1/16/22.
//

import UIKit
import SwiftUI
import Firebase
import SideMenu


protocol TimeViewControllerDelegate: AnyObject {
    func menuPressed()
}


class TimeViewController: UIViewController {
    
    let logger = CircleLogger()
    
    private var authUser : User? {
        return Auth.auth().currentUser
    }
    
    weak var delegate: TimeViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        addGradient()
        
        let navFont = UIFont(name: "PingFangHK-Thin", size: 21)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: navFont!]
        title = "Time"
        
        // Menu Button
        let menuButtonItem = ViewUtils().createMenuButtonItem(#selector(self.menuPressed), controller: self)
        navigationItem.leftBarButtonItem = menuButtonItem
        
        // Add Time Button
        let addTimeButtonItem = ViewUtils().createAddTimeItem(#selector(self.addTimePressed), controller: self)
        navigationItem.rightBarButtonItem = addTimeButtonItem
        
        let tc = TimeClient()
        tc.getFreeTime(uid: authUser!.uid) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let value):
                for entry in value {
                    let start = "Start: \(String(describing: entry!["startDate"]!))"
                    let end = "End: \(String(describing: entry!["endDate"]!))"
                    self.logger.info(msg: start)
                    self.logger.info(msg: end)
                }
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    @objc func menuPressed() {
        delegate?.menuPressed()
    }
    
    @objc func addTimePressed() {
        let msg = "add time pressed"
        self.logger.info(msg: msg)
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
