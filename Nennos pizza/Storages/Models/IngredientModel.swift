//
//  IngredientModel.swift
//  Nennos pizza
//
//  Created by Bence Pattogato on 30/03/17.
//  Copyright © 2017 bence.pattogato. All rights reserved.
//

import Foundation

final class IngredientModel: NSObject, NSCoding {
    
    var id: Int
    var price: Double
    var name: String
    
    init(id: Int, price: Double, name: String) {
        self.id = id
        self.price = price
        self.name = name
    }
    
    init(networkModel: IngredientNetworkModel) {
        self.id = networkModel.id ?? -1
        self.price = networkModel.price ?? 0
        self.name = networkModel.name ?? ""
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(price, forKey: "price")
        aCoder.encode(name, forKey: "name")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeInteger(forKey: "id")
        let price = aDecoder.decodeDouble(forKey: "price")
        let name = aDecoder.decodeObject(forKey: "name") as! String
        self.init(id: id, price: price, name: name)
    }
    
}

func == (lhs: IngredientModel, rhs: IngredientModel) -> Bool {
    return lhs.id == rhs.id
}
