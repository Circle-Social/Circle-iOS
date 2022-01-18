//
//  AddTimeVC.swift
//  Circle
//
//  Created by Sharvil Kekre on 1/2/22.
//

import UIKit
import SwiftUI
import FSCalendar
import Firebase

class AddTimeVC: UIViewController {
    
    let logger = CircleLogger()
    
    private var authUser : User? {
        return Auth.auth().currentUser
    }
    
    private let calendar: FSCalendar = {
        let cal = FSCalendar()
        cal.appearance.headerTitleFont = UIFont(name: "PingFangHK-Thin", size: 18)
        cal.appearance.weekdayFont = UIFont(name: "PingFangHK-Thin", size: 16)
        cal.appearance.headerTitleColor = .black
        cal.appearance.weekdayTextColor = .black
        return cal
    }()
    
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
        let vu = ViewUtils()
        vu.addGradientOne(controller: self)
        let titleView = vu.createTitleSymbol(symbolName: "calendar.badge.clock", controller: self)
        view.addSubview(titleView)
        calendar.delegate = self
        
        view.addSubview(addButton)
        addButton.addTarget(self, action: #selector(addPressed), for: .touchUpInside)
        view.addSubview(cancelButton)
        cancelButton.addTarget(self, action: #selector(cancelPressed), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        calendar.frame = CGRect(
            x: 0,
            y: 75,
            width: view.frame.size.width,
            height: view.frame.size.width
        )
        view.addSubview(calendar)
        
        let buttonWidth = view.frame.width / 2 - 30
        addButton.frame = CGRect(
            x: 15,
            y: view.frame.size.height-75-view.safeAreaInsets.bottom,
            width: buttonWidth,
            height: 50
        )
        
        cancelButton.frame = CGRect(
            x: view.center.x + 15,
            y: view.frame.size.height-75-view.safeAreaInsets.bottom,
            width: buttonWidth,
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


extension AddTimeVC: FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-YYYY"
        let dateStr = formatter.string(from: date)
        self.logger.info(msg: dateStr)
    }
}
