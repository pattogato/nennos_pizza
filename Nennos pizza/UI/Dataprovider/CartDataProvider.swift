//
//  CartDataProvider.swift
//  Nennos pizza
//
//  Created by Bence Pattogato on 29/03/17.
//  Copyright © 2017 bence.pattogato. All rights reserved.
//

import Foundation
import PromiseKit

protocol CartDataProviderDelegate: class {
    func refreshData()
}

protocol CartItemViewModelProtocol {
    var title: String { get }
    var price: Double { get }
}

protocol CartDataProviderProtocol {
    func numberOfRows() -> Int
    func itemAt(indexPath: IndexPath) -> CartItemViewModelProtocol
    func deleteItemAt(indexPath: IndexPath)
    func sumPrice() -> Double
    func checkoutCart() -> Promise<Void>
    
    var delegate: CartDataProviderDelegate? { get set }
}

final class CartDataProvider: CartDataProviderProtocol {
    
    weak var delegate: CartDataProviderDelegate?
    
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
        delegate?.refreshData()
    }
    
    func sumPrice() -> Double {
        return cartManager.getSumPrice()
    }
    
    func checkoutCart() -> Promise<Void> {
        return cartManager.postCart()
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
    
    var delegate: CartDataProviderDelegate?
    
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
    
    func checkoutCart() -> Promise<Void> {
        return Promise { fulfill, reject in fulfill() }
    }
}

