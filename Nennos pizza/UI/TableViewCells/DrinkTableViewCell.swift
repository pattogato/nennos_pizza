//
//  DrinkTableViewCell.swift
//  Nennos pizza
//
//  Created by Bence Pattogato on 29/03/17.
//  Copyright © 2017 bence.pattogato. All rights reserved.
//

import UIKit

class DrinkTableViewCell: SimpleListTableViewCell {

    weak var delegate: ButtonTableViewCellDelegate?
    
    @IBAction func didTapAddButton(_ sender: Any) {
        delegate?.leftButtonTouched(cell: self)
    }
    
    
    func setupUI(viewModel: DrinkViewModelProtocol) {
        self.priceLabel.text = viewModel.price.priceString
        self.nameLabel.text = viewModel.name
    }

}
