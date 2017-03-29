//
//  NotificationHelper.swift
//  Nennos pizza
//
//  Created by Bence Pattogato on 27/03/17.
//  Copyright © 2017 bence.pattogato. All rights reserved.
//

import Whisper


final class NotificationHelper {
    
    private struct Constants {
        static let messageDismissTime: TimeInterval = 3.0
    }
    
    static func showStatusBarMessage(_ message: String, action: (() -> Void)? = nil) {
        let murmur = Murmur(title: message,
                            backgroundColor: Colors.red.withAlphaComponent(0.8),
                            titleColor: .white,
                            font: Fonts.sfDisplaySemibold(size: 14),
                            action: action)
        show(whistle: murmur, action: .show(Constants.messageDismissTime))
    }
    
}
