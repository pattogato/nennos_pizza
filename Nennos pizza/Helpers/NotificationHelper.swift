//
//  NotificationHelper.swift
//  Nennos pizza
//
//  Created by Bence Pattogato on 27/03/17.
//  Copyright © 2017 bence.pattogato. All rights reserved.
//

import CWStatusBarNotification
import UIKit


protocol NotificationProtocol {
    func showStatusBarMessage(_ message: String)
}

extension NotificationProtocol where Self: UIViewController {
    
    func showStatusBarMessage(_ message: String) {
        let notification = CWStatusBarNotification()
        notification.notificationLabelBackgroundColor = Colors.red.withAlphaComponent(0.8)
        notification.notificationLabelTextColor = UIColor.white
        notification.notificationLabelFont = Fonts.sfDisplaySemibold(size: 14)
        notification.display(withMessage: message, forDuration: 3)
    }
}
