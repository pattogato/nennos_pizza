//
//  Stylesheet.swift
//  Nennos pizza
//
//  Created by Bence Pattogato on 25/03/17.
//  Copyright © 2017 bence.pattogato. All rights reserved.
//

import UIKit

    
struct Colors {
    
    static let red = UIColor(netHex: 0xE14D45)
    static let yellow = UIColor(netHex: 0xFFCD2B)
    static let brown = UIColor(netHex: 0x4A4A4A)
}

struct Fonts {

    static func sfDisplayRegular(size: CGFloat) -> UIFont {
        return UIFont(name: "SFUIDisplay-Regular", size: size)!
    }
    
    static func sfDisplayHeavy(size: CGFloat) -> UIFont {
        return UIFont(name: "SFUIDisplay-Heavy", size: size)!
    }
    
    static func sfDisplayBold(size: CGFloat) -> UIFont {
        return UIFont(name: "SFUIDisplay-Bold", size: size)!
    }
    
    static func sfDisplaySemibold(size: CGFloat) -> UIFont {
        return UIFont(name: "SFUIDisplay-Semibold", size: size)!
    }
    
    static func sfDisplayItalic(size: CGFloat) -> UIFont {
        return UIFont(name: "SFUIDisplay-Italic", size: size)!
    }
}

