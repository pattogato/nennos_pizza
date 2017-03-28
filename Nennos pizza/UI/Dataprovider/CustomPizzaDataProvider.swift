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
}

final class MockedCustomPizzaDataProviderProtocol: CustomPizzaDataProviderProtocol {
    
    private var selectedItems = [IndexPath]()
    
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
        return selectedItems.contains(indexPath)
    }
    
    func selecItemAt(indexPath: IndexPath) {
        selectedItems.append(indexPath)
    }
    
    func deSelecItemAt(indexPath: IndexPath) {
        selectedItems = selectedItems.filter({ $0 != indexPath })
    }
    
    func getPizzaImageUrl() -> URL? {
        return URL(string: "https://cdn.pbrd.co/images/tOhJQ5N3.png")
    }
}

struct IngredientViewModel: IngredientViewModelProtocol {
    var name: String
    var currency: String
    var price: Double
}
