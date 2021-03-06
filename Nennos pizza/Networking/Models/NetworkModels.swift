//
//  NetworkModels.swift
//  Nennos pizza
//
//  Created by Bence Pattogato on 29/03/17.
//  Copyright © 2017 bence.pattogato. All rights reserved.
//

import Foundation
import ObjectMapper

/**
 These classes are responsible to map the JSON files from the network to local object models
 */

//class ListNetworkModel<T: Mappable>: Mappable {
//    
//    var elements: [T]?
//    
//    func mapping(map: Map) {
//        
//    }
//    
//}

/**
 Base network superclass only with name
 */
class BaseNetworkModel: Mappable {
    
    var name: String?
    
    func mapping(map: Map) {
        name <- map["name"]
    }
    
    /**
     Unused required initializer
     */
    required init?(map: Map) { }
}

/**
 Network model superclass with id
 */
class IdentifiedNetworkModel: BaseNetworkModel {
    
    var id: Int?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        id <- map["id"]
    }
}

/**
 Drink object mapper model
 */
final class DrinkNetworkModel: IdentifiedNetworkModel {
    
    var price: Double?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        price <- map["price"]
    }

}

/**
 Ingredient object mapper model
 */
final class IngredientNetworkModel: IdentifiedNetworkModel {
    
    var price: Double?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        price <- map["price"]
    }
}

/**
 Pizza's list object mapper
 */
final class PizzaListNetworkModel: Mappable {
    
    var basePrice: Double?
    var pizzas: [PizzaNetworkModel]?
    
    func mapping(map: Map) {
        basePrice <- map["basePrice"]
        pizzas <- map["pizzas"]
    }
    
    init?(map: Map) { }
}

/**
 Pizza object network model
 */
final class PizzaNetworkModel: BaseNetworkModel {
    
    var ingredients: [Int]?
    var imageUrl: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        ingredients <- map["ingredients"]
        imageUrl <- map["imageUrl"]
    }
    
}

/**
 This class's purpose is to provide mapping functionality to serialize the 
 model when posting it to the server
 */
final class PizzaResponseNetworkModel: BaseMappable {
    var name: String?
    var imageUrl: String?
    var ingredients: [Int]?
    
    func mapping(map: Map) {
        ingredients <- map["ingredients"]
        imageUrl <- map["imageUrl"]
        name <- map["name"]
    }
    
    init(model: PizzaModel) {
        self.name = model.name
        self.imageUrl = model.imageUrl?.absoluteString
        self.ingredients = model.ingredients?.map({ return $0.id })
    }
}
