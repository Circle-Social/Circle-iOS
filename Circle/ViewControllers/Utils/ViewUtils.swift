//
//  ViewUtils.swift
//  Circle
//
//  Created by Sharvil Kekre on 1/15/22.
//

import Foundation
import UIKit


class ViewUtils: NSObject {
    
    func createMenuButtonItem(_ menuSelector: Selector, controller: UIViewController) -> UIBarButtonItem? {
        let image = UIImage(named: "LogoClear")
        let scaledImage = image?.resize(withPercentage: 0.05)
        let menuBtn = UIButton(type: .custom)
        
        menuBtn.setBackgroundImage(scaledImage, for: .normal)
        menuBtn.addTarget(controller, action: menuSelector, for: .touchUpInside)
        menuBtn.frame = CGRect(x: menuButtonX, y: menuButtonY, width: menuButtonWidth, height: menuButtonHeight)

        let view = UIView(frame: CGRect(x: menuButtonX, y: menuButtonY, width: menuButtonWidth, height: menuButtonHeight))
        view.bounds = view.bounds.offsetBy(dx: 10, dy: 3)
        view.addSubview(menuBtn)
        let menuButtonItem = UIBarButtonItem(customView: view)
        return menuButtonItem
    }
    
    func createAddTimeItem(_ menuSelector: Selector, controller: UIViewController) -> UIBarButtonItem? {
        let plusIcon = UIImage(systemName: "plus.app")
        let timeBtn = UIButton(type: .custom)
        timeBtn.setBackgroundImage(plusIcon, for: .normal)
        timeBtn.addTarget(controller, action: menuSelector, for: .touchUpInside)
        timeBtn.frame = CGRect(x: timeButtonX, y: timeButtonY, width: timeButtonWidth, height: timeButtonHeight)
        timeBtn.tintColor = UIColor.orange

        let view = UIView(frame: CGRect(x: timeButtonX, y: timeButtonY, width: timeButtonWidth, height: timeButtonHeight))
        view.bounds = view.bounds.offsetBy(dx: 10, dy: 3)
        view.addSubview(timeBtn)
        let timeButtonItem = UIBarButtonItem(customView: view)
        return timeButtonItem
    }
    
    func addGradientOne(controller: UIViewController) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = controller.view.bounds
        gradientLayer.colors = [
            UIColor.white.cgColor,
            UIColor.yellow.cgColor,
            UIColor.orange.cgColor,
            UIColor.red.cgColor
        ]
        controller.view.layer.insertSublayer(gradientLayer, at: 0)
    }
}
