//
//  ThankYouViewContoller.swift
//  Nennos pizza
//
//  Created by Bence Pattogato on 02/04/17.
//  Copyright © 2017 bence.pattogato. All rights reserved.
//

import UIKit

final class ThankYouViewContoller: UIViewController {
    
    var applicationRouter: ApplicationRouterProtocol!
    
    @IBOutlet weak var thankYouLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(self.viewTapped(_:)))
        )
        
    }
    
    func viewTapped(_ sender: UITapGestureRecognizer) {
        applicationRouter.start()
    }
    
}
