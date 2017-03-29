//
//  AlphaDisablaButton.swift
//  Nennos pizza
//
//  Created by Bence Pattogato on 28/03/17.
//  Copyright © 2017 bence.pattogato. All rights reserved.
//

import UIKit

final class AlphaDisableButton: UIButton {
    
    @IBInspectable var enabledAlpha: CGFloat = 1.0
    @IBInspectable var disabledAlpha: CGFloat = 0.5
    
    override var isEnabled: Bool {
        didSet {
            self.alpha = isEnabled ? enabledAlpha : disabledAlpha
        }
    }
    
}
