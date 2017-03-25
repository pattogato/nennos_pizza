//
//  Stylesheet.swift
//  Nennos pizza
//
//  Created by Bence Pattogato on 25/03/17.
//  Copyright © 2017 bence.pattogato. All rights reserved.
//

import UIKit


public struct Stylesheet {
    
    public enum Colors {
        case red
        
        var uiColor: UIColor {
            switch self {
            case .red:
                return 
            default:
                <#code#>
            }
        }
    }
    
    public enum Fonts {
        
    }
    
    static func initialUISetup() {
        self.setupNavigationBarAppearance()
    }
    
    private static func setupNavigationBarAppearance() {
        UINavigationBar.appearance().tintColor =
    }
}
