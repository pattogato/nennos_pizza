//
//  PizzaModel.swift
//  Nennos pizza
//
//  Created by Bence Pattogato on 30/03/17.
//  Copyright © 2017 bence.pattogato. All rights reserved.
//

import Foundation

final class PizzaModel: NSObject, NSCoding {
    
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
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(imageUrl, forKey: "imageUrl")
        aCoder.encode(basePrice, forKey: "basePrice")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(ingredients, forKey: "ingredients")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let imageUrl = aDecoder.decodeObject(forKey: "imageUrl") as! URL
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let basePrice = aDecoder.decodeDouble(forKey: "basePrice")
        let ingredients = aDecoder.decodeObject(forKey: "ingredients") as! [IngredientModel]
        
        self.init(basePrice: basePrice, name: name, ingredients: ingredients, imageUrl: imageUrl)
    }
    
    // Must be here, because extension cannot store property
    var cartId: String = UUID().uuidString
    
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
