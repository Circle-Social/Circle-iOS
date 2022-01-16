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
}
