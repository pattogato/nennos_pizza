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
    var ingredients: [IngredientModel]?
    var imageUrl: URL?
    
    init(basePrice: Double, name: String, ingredients: [IngredientModel]?, imageUrl: URL?) {
        self.basePrice = basePrice
        self.name = name
        self.ingredients = ingredients
        self.imageUrl = imageUrl
    }
    
    init(networkModel: PizzaNetworkModel, basePrice: Double) {
        self.basePrice = basePrice
        self.name = networkModel.name ?? ""
        self.imageUrl = URL(string: networkModel.imageUrl ?? "")
    }
    
}

// To be able to insert to cart
extension PizzaModel: ShoppableItem {
    
    var price: Double {
        var sum: Double = 0
        ingredients?.forEach({ sum += $0.price })
        return basePrice + sum
    }
    
    var associatedObject: AnyObject {
        return self
    }
    
}
