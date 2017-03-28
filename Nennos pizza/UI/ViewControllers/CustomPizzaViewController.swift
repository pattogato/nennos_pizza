//
//  CutomPizzaViewController.swift
//  Nennos pizza
//
//  Created by Bence Pattogato on 27/03/17.
//  Copyright © 2017 bence.pattogato. All rights reserved.
//

import UIKit
import AlamofireImage

protocol IngredientViewModelProtocol {
    var name: String { get }
    var price: Double { get }
    var currency: String { get }
}

class CustomPizzaViewController: UIViewController {

    var dataProvider: CustomPizzaDataProviderProtocol!
    
    @IBOutlet weak var pizzaImageView: UIImageView!
    
    
    fileprivate struct Constants {
        static let ingredientCellIdentifier = "IngredientTableViewCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let imageUrl = dataProvider.getPizzaImageUrl() {
            pizzaImageView.af_setImage(
                withURL: imageUrl,
                placeholderImage: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func didTapAddToCartButton(_ sender: Any) {
        // TODO: add to cart & show cart view on tap
        print("add to cart")
        NotificationHelper.showStatusBarMessage("notification.added.to.cart".localized, action: nil)
    }
    
}

extension CustomPizzaViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataProvider.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: Constants.ingredientCellIdentifier, for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? IngredientTableViewCell else {
            assertionFailure("Cell's class not set properly")
            return
        }
        
        cell.setupUI(viewModel: dataProvider.modelFor(indexPath: indexPath))
        cell.setSelected(dataProvider.isModelSelected(indexPath: indexPath), animated: false)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dataProvider.selecItemAt(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        dataProvider.deSelecItemAt(indexPath: indexPath)
    }
}
