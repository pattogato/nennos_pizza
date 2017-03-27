//
//  IngredientTableViewCell.swift
//  Nennos pizza
//
//  Created by Bence Pattogato on 27/03/17.
//  Copyright © 2017 bence.pattogato. All rights reserved.
//

import UIKit

class IngredientTableViewCell: UITableViewCell {
    
    // MARK: Outlets
    @IBOutlet weak var tickImageView: UIImageView!
    @IBOutlet weak var ingredientNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    func setupUI(viewModel: IngredientViewModel) {
        self.ingredientNameLabel.text = viewModel.name
        self.priceLabel.text = viewModel.currency + " " + "\(viewModel.price)"
    }
    
    override var isSelected: Bool {
        didSet {
            self.tickImageView.isHidden = !isSelected
        }
    }

}
