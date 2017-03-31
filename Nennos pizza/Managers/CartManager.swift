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
    var associatedObject: AnyObject { get set }
    var cartId: String { get }
}

protocol CartManagerProtocol {
    func addItemToCart(item: ShoppableItem)
    func removeItemFromCart(item: ShoppableItem)
}

final class CartManager: CartManagerProtocol {
    
    private var items = [ShoppableItem]()
    
    func addItemToCart(item: ShoppableItem) {
        items.append(item)
    }
    
    func removeItemFromCart(item: ShoppableItem) {
        items = items.filter({ $0.cartId != item.cartId })
    }
    
}
