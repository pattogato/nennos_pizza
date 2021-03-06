//
//  CutomPizzaViewController.swift
//  Nennos pizza
//
//  Created by Bence Pattogato on 27/03/17.
//  Copyright © 2017 bence.pattogato. All rights reserved.
//

import UIKit
import AlamofireImage
import SnapKit

class CustomPizzaViewController: UIViewController, NotificationProtocol {
    
    var dataProvider: CustomPizzaDataProviderProtocol!
    
    @IBOutlet weak var pizzaImageView: UIImageView!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate struct Constants {
        static let ingredientCellIdentifier = "IngredientTableViewCell"
        static let headerHeight: CGFloat = 77.0
        static let headerTitle = "Ingredients"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataProvider.delegate = self
        setupData()
    }
    
    private func setupData() {
        _ = dataProvider.loadDataIfNeeded().then { _ -> Void in
                self.tableView.reloadData()
                self.setupUI()
            }.catch { (error) in
                AlertHelper.showError(from: self,
                                      error: error,
                                      retryActionHandler: { (_) in
                                        self.setupData()
                })
        }
    }
    
    fileprivate func setupUI() {
        // Setup pizza image
        if dataProvider.isCreateMode {
            pizzaImageView.image = #imageLiteral(resourceName: "im_empty_pizza")
        } else if let imageUrl = dataProvider.getPizzaImageUrl() {
            pizzaImageView.af_setImage(
                withURL: imageUrl,
                placeholderImage: nil)
        }
        
        DispatchQueue.main.async {
            self.setupAddToCartButton(priceString: self.dataProvider.getSumPrice().priceString)
            
            for indexPath in self.dataProvider.selectedItems() {
                self.tableView.selectRow(at: indexPath,
                                    animated: false,
                                    scrollPosition: .none)
            }
        }
        
    }
    
    fileprivate func setupAddToCartButton(priceString: String) {
        self.addToCartButton.isEnabled = dataProvider.isAddToCartButtonEnabled
        addToCartButton.setTitle(
            String(format: "custom.button.addtocart".localized, priceString),
            for: .normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func didTapAddToCartButton(_ sender: Any) {
        if dataProvider.addPizzaToCart() == false {
            AlertHelper.showAlert(title: "custom.empty".localized,
                                  message: "custom.empty.message".localized,
                                  cancelTitle: "error.ok".localized,
                                  from: self)
        } else {
            self.showStatusBarMessage("notification.added.to.cart".localized)
        }
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
        do {
            cell.setupUI(viewModel: try dataProvider.modelFor(indexPath: indexPath))
        } catch {
            AlertHelper.showAlert(title: "error.title".localized,
                                  message: "error.network.message".localized,
                                  cancelTitle: "error.ok".localized,
                                  from: self)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dataProvider.selecItemAt(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        dataProvider.deSelecItemAt(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return Constants.headerHeight
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return createHeaderView(section: section, tableView: tableView)
    }
    
    private func createHeaderView(section: Int, tableView: UITableView) -> UIView? {
        if section == 0 {
            let view = UIView(frame:
                CGRect(x: 0,
                       y: 0,
                       width: tableView.frame.width,
                       height: Constants.headerHeight))
            view.backgroundColor = .white
            
            let label = UILabel()
            label.text = Constants.headerTitle
            view.addSubview(label)
            
            label.snp.makeConstraints { (make) in
                make.leading.equalTo(view.snp.leading).offset(12)
                make.trailing.equalTo(view.snp.trailing).offset(12)
                make.centerY.equalTo(view.snp.centerY)
            }
            
            label.textColor = Colors.brown
            label.font = Fonts.sfDisplayBold(size: 24)
            return view
        }
        return nil
    }
}

extension CustomPizzaViewController: CustomPizzaDataProviderDelegate {
    
    func refreshSumPrice(price: Double) {
        setupAddToCartButton(priceString: price.priceString)
    }
    
}
