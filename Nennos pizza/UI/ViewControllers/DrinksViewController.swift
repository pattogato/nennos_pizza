//
//  DrinksViewController.swift
//  Nennos pizza
//
//  Created by Bence Pattogato on 29/03/17.
//  Copyright © 2017 bence.pattogato. All rights reserved.
//

import UIKit

class DrinksViewController: UIViewController, NotificationProtocol {

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
        loadData()
    }
    
    private func loadData() {
        LoaderHelper.showLoader()
        dataProvider.loadDataIfNeeded().then { _ -> Void in
            self.tableView.reloadData()
        }.catch { (error) in
            AlertHelper.showError(from: self,
                                  error: error,
                                  retryActionHandler: { _ in
                                    self.loadData()
            })
        }.always {
            LoaderHelper.dismissLoader()
        }
    }

}

extension DrinksViewController: ButtonTableViewCellDelegate {
    
    func buttonTouched(cell: UITableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            dataProvider.addItemToCartAt(indexPath: indexPath)
            self.showStatusBarMessage("notification.added.to.cart".localized)
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
            do {
                cell.setupUI(viewModel: try dataProvider.itemAt(indexPath: indexPath))
            } catch {
                AlertHelper.showNetworkAlert(from: self, retryActionHandler: nil)
            }
            
            cell.delegate = self
        }
    }
}
