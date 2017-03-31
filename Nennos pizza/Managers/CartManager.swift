//
//  CartManager.swift
//  Nennos pizza
//
//  Created by Bence Pattogato on 31/03/17.
//  Copyright © 2017 bence.pattogato. All rights reserved.
//

import Foundation

protocol ShoppableItem {
    var name: String { get }
    var price: Double { get }
    var associatedObject: AnyObject { get }
    var cartId: String { get }
}

extension ShoppableItem {
    var cartId: String {
        return UUID().uuidString
    }
}

protocol CartManagerProtocol {
    func addItemToCart(item: ShoppableItem)
    func removeItemFromCart(item: ShoppableItem)
    func getSumPrice() -> Double
    
    var items: [ShoppableItem] { get }
}

final class CartManager: CartManagerProtocol {
    
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
    
}
