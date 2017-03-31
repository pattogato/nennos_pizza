//
//  SimpleListTableViewCell.swift
//  Nennos pizza
//
//  Created by Bence Pattogato on 29/03/17.
//  Copyright © 2017 bence.pattogato. All rights reserved.
//

import UIKit

protocol ButtonTableViewCellDelegate: class {
    func buttonTouched(cell: UITableViewCell)
}

class SimpleListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.nameLabel.textColor = Colors.brown
        self.priceLabel.textColor = Colors.brown
    }
}
