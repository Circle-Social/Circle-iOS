//
//  HomeVC.swift
//  Circle
//
//  Created by Sharvil Kekre on 1/2/22.
//

import UIKit
import SwiftUI
import Firebase
import SideMenu


protocol HomeViewControllerDelegate: AnyObject {
    func menuPressed()
}


class HomeViewController: UIViewController {
    
    private var authUser : User? {
        return Auth.auth().currentUser
    }
    
    weak var delegate: HomeViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        addGradient()
        
        let navFont = UIFont(name: "PingFangHK-Thin", size: 21)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: navFont!]
        title = "Home"
        
        let menuButtonItem = ViewUtils().createMenuButtonItem(#selector(self.menuPressed), controller: self)
        navigationItem.leftBarButtonItem = menuButtonItem
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    @objc func menuPressed() {
        delegate?.menuPressed()
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
