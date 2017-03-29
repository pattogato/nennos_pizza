//
//  StyledNavigationViewController.swift
//  Nennos pizza
//
//  Created by Bence Pattogato on 29/03/17.
//  Copyright © 2017 bence.pattogato. All rights reserved.
//

import UIKit

class StyledNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName : Colors.red,
            NSFontAttributeName : Fonts.sfDisplayHeavy(size: 17.0)]
        self.navigationBar.tintColor = Colors.red
    }
}
