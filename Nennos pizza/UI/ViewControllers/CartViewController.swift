//
//  CartViewController.swift
//  Nennos pizza
//
//  Created by Bence Pattogato on 29/03/17.
//  Copyright © 2017 bence.pattogato. All rights reserved.
//

import UIKit

protocol CartItemViewModelProtocol {
    var title: String { get }
    var price: Double { get }
}

class CartViewController: UIViewController {

    fileprivate struct Constants {
        static let cartCellIdentifier = "CartTableViewCell"
        static let normalRowHeight: CGFloat = 44.0
        static let totalRowHeight: CGFloat = 70.0
    }
    
    var dataProvider: CartDataProviderProtocol!
    
    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "cart.title".localized
    }
    
    @IBAction func didTapCheckoutButton(_ sender: Any) {
        print("check")
    }

}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    
    fileprivate func isTotalRow(indexPath: IndexPath) -> Bool {
        return indexPath.row == dataProvider.numberOfRows()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Plus one for total row
        return dataProvider.numberOfRows() + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: Constants.cartCellIdentifier, for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? CartTableViewCell {
            if isTotalRow(indexPath: indexPath) {
                cell.setupTotalUI(price: dataProvider.sumPrice())
            } else {
                cell.setupUI(viewModel: dataProvider.itemAt(indexPath: indexPath))
                cell.delegate = self
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isTotalRow(indexPath: indexPath) {
            return Constants.totalRowHeight
        } else {
            return Constants.normalRowHeight
        }
    }
    
}

extension CartViewController: ButtonTableViewCellDelegate {
    
    func buttonTouched(cell: UITableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            self.dataProvider.deleteItemAt(indexPath: indexPath)
        }
    }
    
}
