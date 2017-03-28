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
    
    func setupUI(viewModel: IngredientViewModelProtocol) {
        self.ingredientNameLabel.text = viewModel.name
        self.priceLabel.text = viewModel.currency + " " + "\(viewModel.price)"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.tickImageView.isHidden = !selected
        
        
    }

}
