//
//  PizzaModel.swift
//  Nennos pizza
//
//  Created by Bence Pattogato on 30/03/17.
//  Copyright © 2017 bence.pattogato. All rights reserved.
//

import Foundation

final class PizzaModel {
    
    var basePrice: Double
    var name: String
    var ingredientIds: [Int]?
    
    init(basePrice: Double, name: String, ingredientIds: [Int]?) {
        self.basePrice = basePrice
        self.name = name
        self.ingredientIds = ingredientIds
    }
    
    init(networkModel: PizzaNetworkModel, basePrice: Double) {
        self.basePrice = basePrice
        self.name = networkModel.name ?? ""
        self.ingredientIds = networkModel.ingredients
    }
    
    // TODO: Implement PizzaViewModelProtocol var
//    var viewModel: Pizza {
//        return DrinkViewModel(name: self.name, price: self.price)
//    }
}
