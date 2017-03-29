//
//  CustomPizzaDataProvider.swift
//  Nennos pizza
//
//  Created by Bence Pattogato on 27/03/17.
//  Copyright © 2017 bence.pattogato. All rights reserved.
//

import UIKit

protocol CustomPizzaDataProviderProtocol {
    func numberOfRows() -> Int
    func modelFor(indexPath: IndexPath) -> IngredientViewModelProtocol
    func isModelSelected(indexPath: IndexPath) -> Bool
    func selecItemAt(indexPath: IndexPath)
    func deSelecItemAt(indexPath: IndexPath)
    func getPizzaImageUrl() -> URL?
    func getPriceString() -> String
    
    var isAddToCartButtonEnabled: Bool { get }
    var delegate: CustomPizzaDataProviderDelegate? { get set }
}

protocol CustomPizzaDataProviderDelegate: class {
    func refreshSumPrice(priceString: String)
}

final class MockedCustomPizzaDataProviderProtocol: CustomPizzaDataProviderProtocol {
    
    weak var delegate: CustomPizzaDataProviderDelegate?
    
    private var selectedIndexPaths = [IndexPath]()
    
    func numberOfRows() -> Int {
        return 15
    }
    
    func modelFor(indexPath: IndexPath) -> IngredientViewModelProtocol {
        return IngredientViewModel(
            name: "model \(indexPath.row)",
            currency: "$",
            price: Double(indexPath.row))
    }
    
    func isModelSelected(indexPath: IndexPath) -> Bool {
        return selectedIndexPaths.contains(indexPath)
    }
    
    func selecItemAt(indexPath: IndexPath) {
        selectedIndexPaths.append(indexPath)
        delegate?.refreshSumPrice(priceString: self.getPriceString())
    }
    
    func deSelecItemAt(indexPath: IndexPath) {
        selectedIndexPaths = selectedIndexPaths.filter({ $0 != indexPath })
        delegate?.refreshSumPrice(priceString: self.getPriceString())
    }
    
    func getPizzaImageUrl() -> URL? {
        return URL(string: "https://cdn.pbrd.co/images/tOhJQ5N3.png")
    }
    
    var isAddToCartButtonEnabled: Bool {
        return selectedIndexPaths.count != 0
    }
    
    func getPriceString() -> String {
        var sumPrice: Double = 0
        selectedIndexPaths.forEach({ sumPrice += modelFor(indexPath: $0).price })
        // TODO: Currency should be properly handled
        return "$\(sumPrice)"
    }
}

struct IngredientViewModel: IngredientViewModelProtocol {
    var name: String
    var currency: String
    var price: Double
}
