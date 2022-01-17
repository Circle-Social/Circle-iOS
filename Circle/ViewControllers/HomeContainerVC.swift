//
//  HomeContainerVC.swift
//  Circle
//
//  Created by Sharvil Kekre on 1/15/22.
//

import UIKit

class HomeContainerVC: UIViewController {

    enum MenuState {
        case opened
        case closed
    }
    
    private var menuState: MenuState = .closed
    
    let menuVC = MenuVC()
    let homeVC = HomeViewController()
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
        homeVC.delegate = self
        let navVC = UINavigationController(rootViewController: homeVC)
        addChild(navVC)
        view.addSubview(navVC.view)
        navVC.didMove(toParent: self)
        self.navVC = navVC
    }
}


extension HomeContainerVC: HomeViewControllerDelegate {
    
    func menuPressed() {
        toggleMenu(completion: nil)
    }
    
    func toggleMenu(completion: (() -> Void)?) {
        switch menuState {
        case .closed:
            // open menu
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                
                self.navVC?.view.frame.origin.x = self.homeVC.view.frame.size.width - 100
                
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


extension HomeContainerVC: MenuViewControllerDelegate {
    
    func didSelect(menuItem: MenuVC.MenuItems) {
        toggleMenu {
            switch menuItem {
            case .home:
                break
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
    
    func logout() {
        FirebaseUtils().logOutUser()
        self.performSegue(withIdentifier: "homeLogout", sender: nil)
    }
}
