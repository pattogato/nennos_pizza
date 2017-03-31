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
    var imageUrl: URL?
    
    init(basePrice: Double, name: String, ingredientIds: [Int]?, imageUrl: URL?) {
        self.basePrice = basePrice
        self.name = name
        self.ingredientIds = ingredientIds
        self.imageUrl = imageUrl
    }
    
    init(networkModel: PizzaNetworkModel, basePrice: Double) {
        self.basePrice = basePrice
        self.name = networkModel.name ?? ""
        self.ingredientIds = networkModel.ingredients
        self.imageUrl = URL(string: networkModel.imageUrl ?? "")
    }
    
    // TODO: Implement PizzaViewModelProtocol var
//    var viewModel: Pizza {
//        return DrinkViewModel(name: self.name, price: self.price)
//    }
}

// To be able to insert to cart
extension PizzaModel: ShoppableItem {
    
    var price: Double {
        return basePrice
    }
    
    var associatedObject: AnyObject {
        return self
    }
    
}
