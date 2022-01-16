//
//  MenuVC.swift
//  Circle
//
//  Created by Sharvil Kekre on 1/15/22.
//

import UIKit

protocol MenuViewControllerDelegate: AnyObject {
    func didSelect(menuItem: MenuVC.MenuItems)
}

class MenuVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    weak var delegate: MenuViewControllerDelegate?
    
    enum MenuItems: String, CaseIterable {
        case home = "Home"
        case time = "Time"
        case circles = "Circles"
        case settings = "Settings"
        case logout = "Logout"
        
        var imageName: String {
            switch self {
            case .home:
                return "house"
            case .time:
                return "clock.circle"
            case .circles:
                return "circle.hexagonpath"
            case .settings:
                return "gear.circle"
            case .logout:
                return "delete.forward"
            }
        }
    }
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = darkOrange
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = darkOrange
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.bounds.size.width, height: view.bounds.size.height)
    }
    
    // Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuItems.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = MenuItems.allCases[indexPath.row].rawValue
        cell?.textLabel?.textColor = .white
        cell?.imageView?.image = UIImage(systemName: MenuItems.allCases[indexPath.row].imageName)
        cell?.imageView?.tintColor = .white
        cell?.backgroundColor = darkOrange
        cell?.contentView.backgroundColor = darkOrange
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = MenuItems.allCases[indexPath.row]
        delegate?.didSelect(menuItem: item)
    }

}
