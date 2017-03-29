//
//  CartTableViewCell.swift
//  Nennos pizza
//
//  Created by Bence Pattogato on 29/03/17.
//  Copyright © 2017 bence.pattogato. All rights reserved.
//

import UIKit

protocol CartTableViewCellDelegate: class {
    func deleteButtonTouched(cell: CartTableViewCell)
}

class CartTableViewCell: UITableViewCell {

    weak var delegate: CartTableViewCellDelegate?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var deleteButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.nameLabel.textColor = Colors.brown
        self.priceLabel.textColor = Colors.brown
    }
    
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
        delegate?.deleteButtonTouched(cell: self)
    }
    
    private func setUIMode(total: Bool) {
        self.nameLabel.font = total ? Fonts.sfDisplayBold(size: 17) : Fonts.sfDisplayRegular(size: 17)
        self.priceLabel.font = nameLabel.font
        self.deleteButton.isHidden = total
        
    }
    
}
