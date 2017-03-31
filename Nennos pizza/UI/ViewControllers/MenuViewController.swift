//
//  MenuViewController.swift
//  Nennos pizza
//
//  Created by Bence Pattogato on 25/03/17.
//  Copyright © 2017 bence.pattogato. All rights reserved.
//

import UIKit

protocol MenuItemViewModelProtocol {
    var imageUrl: URL? { get }
    var title: String { get }
    var ingredients: String { get }
    var price: Double { get }
}

class MenuViewController: UIViewController {

    fileprivate struct Constants {
        static let menuCellIdentifier = "MenuTableViewCell"
        static let rowHeight: CGFloat = 178.0
        static let createSegueIdentifier = "toCustomPizzaSegue"
    }
    
    var dataProvider: MenuDataProviderProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "menu.title".localized
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let customPizzaVC = segue.destination as? CustomPizzaViewController {
            // Open custom screen from cell tap
            if let indexPath = sender as? IndexPath {
                // TODO: Complete
            } else if let barButton = sender as? UIBarButtonItem {
                // Open create pizza screen from bar button tap
                // TODO: Complete
            }
        }
    }
    
    // IBActions
    @IBAction func didTouchCreateBarButton(_ sender: Any) {
        self.performSegue(withIdentifier: Constants.createSegueIdentifier, sender: sender)
    }
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataProvider.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: Constants.menuCellIdentifier, for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? MenuTableViewCell {
            do {
                cell.setupUI(viewModel: try dataProvider.itemAt(indexPath: indexPath))
            } catch {
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.rowHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: Constants.createSegueIdentifier, sender: indexPath)
    }
    
}
