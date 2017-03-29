//
//  CartTableViewCell.swift
//  Nennos pizza
//
//  Created by Bence Pattogato on 29/03/17.
//  Copyright © 2017 bence.pattogato. All rights reserved.
//

import UIKit



class CartTableViewCell: SimpleListTableViewCell {

    weak var delegate: ButtonTableViewCellDelegate?

    @IBOutlet weak var deleteButton: UIButton!
    
    func setupTotalUI(price: Double) {
        self.nameLabel.text = "cart.total".localized
        self.priceLabel.text = price.priceString
        setUIMode(total: true)
    }
    
    func setupUI(viewModel: CartItemViewModelProtocol) {
        self.nameLabel.text = viewModel.title
        self.priceLabel.text = viewModel.price.priceString
        setUIMode(total: false)
    }
    
    @IBAction func didTapDeleteButton(_ sender: Any) {
        delegate?.leftButtonTouched(cell: self)
    }
    
    private func setUIMode(total: Bool) {
        self.nameLabel.font = total ? Fonts.sfDisplayBold(size: 17) : Fonts.sfDisplayRegular(size: 17)
        self.priceLabel.font = nameLabel.font
        self.deleteButton.isHidden = total
        
    }
    
}
