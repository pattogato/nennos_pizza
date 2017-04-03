//
//  CartManager.swift
//  Nennos pizza
//
//  Created by Bence Pattogato on 31/03/17.
//  Copyright © 2017 bence.pattogato. All rights reserved.
//

import Foundation
import PromiseKit

protocol ShoppableItem {
    var name: String { get }
    var price: Double { get }
    var associatedObject: AnyObject { get }
    var cartId: String { get }
}

protocol CartManagerProtocol {
    func addItemToCart(item: ShoppableItem)
    func removeItemFromCart(item: ShoppableItem)
    func getSumPrice() -> Double
    func postCart() -> Promise<Void>
    func clearCart()
    
    var items: [ShoppableItem] { get }
}

final class CartManager: CartManagerProtocol {
    
    let services: ServicesProtocol
    
    init(services: ServicesProtocol) {
        self.services = services
    }
    
    var items = [ShoppableItem]()
    
    func addItemToCart(item: ShoppableItem) {
        items.append(item)
    }
    
    func removeItemFromCart(item: ShoppableItem) {
        items = items.filter({ $0.cartId != item.cartId })
    }
    
    func getSumPrice() -> Double {
        var price: Double = 0.0
        items.forEach({ price += $0.price })
        return price
    }
    
    func postCart() -> Promise<Void> {
        var drinks = [DrinkModel]()
        var pizzas = [PizzaModel]()
        items.forEach { (cartItem) in
            if let drink = cartItem.associatedObject as? DrinkModel {
                drinks.append(drink)
            }
            if let pizza = cartItem.associatedObject as? PizzaModel {
                pizzas.append(pizza)
            }
        }
        
        return services.postCart(
            drinkIds: drinks.map({ $0.id }),
            pizzas: pizzas.map({ return PizzaResponseNetworkModel(model: $0)  })
        ).then(execute: { (_) -> Promise<Void> in
            self.clearCart()
            return Promise { fulfill, reject in fulfill() }
        })
    }
    
    func clearCart() {
        self.items.removeAll()
    }
    
}
