//
//  MenuTableViewCell.swift
//  Nennos pizza
//
//  Created by Bence Pattogato on 29/03/17.
//  Copyright © 2017 bence.pattogato. All rights reserved.
//

import UIKit

// TODO: CEll delegate with cart button touch

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var pizzaImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var addToCartButton: AddToCartUIButton!
    
    weak var delegate: ButtonTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        nameLabel.textColor = Colors.brown
        ingredientsLabel.textColor = Colors.brown
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupUI(viewModel: MenuItemViewModelProtocol) {
        if let url = viewModel.imageUrl {
            pizzaImageView.af_setImage(withURL: url)
        }
        nameLabel.text = viewModel.title
        ingredientsLabel.text = viewModel.ingredients
        addToCartButton.setPrice(viewModel.price)
    }
    
    @IBAction func didTapAddToCartButton(_ sender: Any) {
        delegate?.buttonTouched(cell: self)
    }
    
    
}
