//
//  TimeContrainerVC.swift
//  Circle
//
//  Created by Sharvil Kekre on 1/16/22.
//

import UIKit

class TimeContainerVC: UIViewController {

    enum MenuState {
        case opened
        case closed
    }
    
    private var menuState: MenuState = .closed
    
    let menuVC = MenuVC()
    let timeVC = TimeViewController()
    var navVC: UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildVCs()
    }
    
    private func addChildVCs() {
        // Menu
        menuVC.delegate = self
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        view.backgroundColor = darkOrange
        
        // Home
        timeVC.delegate = self
        let navVC = UINavigationController(rootViewController: timeVC)
        addChild(navVC)
        view.addSubview(navVC.view)
        navVC.didMove(toParent: self)
        self.navVC = navVC
    }
}


extension TimeContainerVC: TimeViewControllerDelegate {
    
    func menuPressed() {
        toggleMenu(completion: nil)
    }
    
    func toggleMenu(completion: (() -> Void)?) {
        switch menuState {
        case .closed:
            // open menu
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                
                self.navVC?.view.frame.origin.x = self.timeVC.view.frame.size.width - 100
                
            } completion: { [weak self] done in
                if done {
                    self?.menuState = .opened
                }
            }
        case .opened:
            // close menu
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                
                self.navVC?.view.frame.origin.x = 0
                
            } completion: { [weak self] done in
                if done {
                    self?.menuState = .closed
                    DispatchQueue.main.async {
                        completion?()
                    }
                }
            }
        }
    }
}


extension TimeContainerVC: MenuViewControllerDelegate {
    
    func didSelect(menuItem: MenuVC.MenuItems) {
        toggleMenu {
            switch menuItem {
            case .home:
                self.home()
            case .time:
                break
            case .circles:
                break
            case .settings:
                break
            case .logout:
                self.logout()
            }
        }
    }
    
    func home() {
        self.performSegue(withIdentifier: "time2home", sender: nil)
    }
    
    func logout() {
        let success = FirebaseUtils().logOutUser()
        if (success) {
            self.performSegue(withIdentifier: "homeLogout", sender: nil)
        } else {
            let alertController = UIAlertController(title: "Logout Failure", message: "Please try again", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)

            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
