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
        
        let navFont = UIFont(name: "PingFangHK-Thin", size: 21)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: navFont!]
        title = "Home"
        
        let menuButtonItem = ViewUtils().createMenuButtonItem(#selector(self.menuPressed), controller: self)
        navigationItem.leftBarButtonItem = menuButtonItem
        
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
