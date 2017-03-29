//
//  DrinksViewController.swift
//  Nennos pizza
//
//  Created by Bence Pattogato on 29/03/17.
//  Copyright © 2017 bence.pattogato. All rights reserved.
//

import UIKit

protocol DrinkViewModelProtocol {
    var name: String { get }
    var price: Double { get }
}

class DrinksViewController: UIViewController {

    fileprivate struct Constants {
        static let drinkCellIdentifier = "DrinkTableViewCell"
    }
    
    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    var dataProvider: DrinksDataProviderProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "drinks.title".localized
    }

}

extension DrinksViewController: ButtonTableViewCellDelegate {
    
    func leftButtonTouched(cell: UITableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            dataProvider.addItemToCartAt(indexPath: indexPath)
        }
    }
}

extension DrinksViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataProvider.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: Constants.drinkCellIdentifier, for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? DrinkTableViewCell {
            cell.setupUI(viewModel: dataProvider.itemAt(indexPath: indexPath))
            cell.delegate = self
        }
    }
}
