//
//  AddToCartUIButton.swift
//  Nennos pizza
//
//  Created by Bence Pattogato on 29/03/17.
//  Copyright © 2017 bence.pattogato. All rights reserved.
//

import UIKit

class AddToCartUIButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = Colors.yellow
        self.setImage(#imageLiteral(resourceName: "ic_cart_button"), for: .normal)
        self.tintColor = .white
        self.layer.cornerRadius = 4.0
        self.titleLabel?.font = Fonts.sfDisplayBold(size: 16.0)
        self.contentEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
    
    func setPrice(_ price: Double) {
        self.setTitle(price.priceString, for: .normal)
        self.sizeToFit()
    }

}
