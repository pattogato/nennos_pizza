//
//  Extensions.swift
//  Nennos pizza
//
//  Created by Bence Pattogato on 25/03/17.
//  Copyright © 2017 bence.pattogato. All rights reserved.
//

import UIKit

extension String {
    
    var localized: String {
        return NSLocalizedString(self, tableName: "Localizable", bundle: Bundle.main, value: "", comment: "")
    }
    
}

extension Double {
    private struct Constants {
        static let priceFormat = "$%.1f"
    }
    
    var priceString: String {
        return String(format: Constants.priceFormat, self)
    }
}

// Source: http://stackoverflow.com/questions/24263007/how-to-use-hex-colour-values-in-swift-ios
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

/**
 Compare two arrays by their element's values
 */
func ~= <T: Equatable>(left: [T], right: [T]) -> Bool {
    var retVal = true
    for item in left {
        if !right.contains(item) {
            retVal = false
            break
        }
    }
    return retVal
}
