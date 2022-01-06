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


class HomeViewController: UIViewController {
    
    private var authUser : User? {
        return Auth.auth().currentUser
    }
    
    var menu: SideMenuNavigationController?
    private let menuButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = UIColor.white
        configuration.buttonSize = .large

        let button = UIButton(configuration: configuration, primaryAction: nil)
        var image = UIImage(named: "LogoClear")
        var scaledImage = image?.resize(withPercentage: 0.05)
        
        button.setImage(scaledImage, for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.adjustsImageSizeForAccessibilityContentSizeCategory = true
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addGradient()
        
        let homeMsg = UITextView(frame: CGRect(x: view.center.x-50, y: 10, width: 100, height: 100))
        homeMsg.textAlignment = .center
        homeMsg.textColor = UIColor.black
        homeMsg.backgroundColor = UIColor(white: 1, alpha: 0.0)
        let text = "Home"
        homeMsg.text = text
        homeMsg.font = UIFont(name: "PingFangHK-Thin", size: 21)
        view.addSubview(homeMsg)
        
        menu = SideMenuNavigationController(rootViewController: MenuListController())
        menu?.leftSide = true
        menu?.setNavigationBarHidden(true, animated: false)
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        view.addSubview(menuButton)
        menuButton.addTarget(self, action: #selector(menuPressed), for: .touchUpInside)
        
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
        
        menuButton.frame = CGRect(
            x: headerButtonX,
            y: headerButtonY,
            width: headerButtonWidth,
            height: headerButtonHeight
        )
    }
    
    @objc func menuPressed() {
        present(menu!, animated: true)
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

class MenuListController: UITableViewController {
    
    let darkOrange = UIColor(red: 0.75, green: 0.41, blue: 0.0, alpha: 1)
    var items = [
        "Profile",
        "Settings",
        "Logout"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = darkOrange
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.backgroundColor = darkOrange
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // do something
    }
}
