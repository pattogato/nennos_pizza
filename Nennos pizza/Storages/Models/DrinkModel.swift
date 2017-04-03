//
//  DrinkMOdel.swift
//  Nennos pizza
//
//  Created by Bence Pattogato on 30/03/17.
//  Copyright © 2017 bence.pattogato. All rights reserved.
//

import Foundation
import ObjectMapper

final class DrinkModel: NSObject, NSCoding {
    
    var id: Int
    var price: Double
    var name: String
    
    init(id: Int, price: Double, name: String) {
        self.id = id
        self.price = price
        self.name = name
    }

    convenience init(networkModel: DrinkNetworkModel) {
        self.init(id: networkModel.id ?? -1,
                  price: networkModel.price ?? 0,
                  name: networkModel.name ?? "")
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
    
    var cartId: String = UUID().uuidString
    
}

extension DrinkModel: ShoppableItem {
    
    var associatedObject: AnyObject {
        return self
    }
    
}
