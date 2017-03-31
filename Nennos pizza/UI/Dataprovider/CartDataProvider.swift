//
//  CartDataProvider.swift
//  Nennos pizza
//
//  Created by Bence Pattogato on 29/03/17.
//  Copyright © 2017 bence.pattogato. All rights reserved.
//

import Foundation

protocol CartDataProviderProtocol {
    func numberOfRows() -> Int
    func itemAt(indexPath: IndexPath) -> CartItemViewModelProtocol
    func deleteItemAt(indexPath: IndexPath)
    func sumPrice() -> Double
}

final class CartDataProvider: CartDataProviderProtocol {
    
    let cartManager: CartManagerProtocol
    
    init(cartManager: CartManagerProtocol) {
        self.cartManager = cartManager
    }
    
    func numberOfRows() -> Int {
        return cartManager.items.count
    }
    
    func itemAt(indexPath: IndexPath) -> CartItemViewModelProtocol {
        return CartItemViewModel(shoppableModel: cartManager.items[indexPath.row])
    }
    
    func deleteItemAt(indexPath: IndexPath) {
        cartManager.removeItemFromCart(item: cartManager.items[indexPath.row])
    }
    
    func sumPrice() -> Double {
        return cartManager.getSumPrice()
    }
    
}

fileprivate struct CartItemViewModel: CartItemViewModelProtocol {
    var price: Double
    var title: String
    
    init(price: Double, title: String) {
        self.price = price
        self.title = title
    }
    
    init(shoppableModel: ShoppableItem) {
        self.price = shoppableModel.price
        self.title = shoppableModel.name
    }
}

final class MockedCartDataProvider: CartDataProviderProtocol {
    
    func numberOfRows() -> Int {
        return 9
    }
    
    func itemAt(indexPath: IndexPath) -> CartItemViewModelProtocol {
        return CartItemViewModel(price: Double(indexPath.row * 2),
                                 title: "element #\(indexPath.row)")
    }
    
    func deleteItemAt(indexPath: IndexPath) {
        // TODO: Implement
        print("delete")
    }
    
    func sumPrice() -> Double {
        return 66.0
    }
}

