//
//  CartTests.swift
//  Nennos pizza
//
//  Created by Bence Pattogato on 03/04/17.
//  Copyright © 2017 bence.pattogato. All rights reserved.
//

import XCTest
import Nimble

class CartTests: XCTestCase {
    
    var cartManager: CartManagerProtocol!
    
    override func setUp() {
        super.setUp()
        
        self.cartManager = DIManager.resolve(service: CartManagerProtocol.self)
        self.cartManager.clearCart()
    }
    
    func testAddItemToCart() {
        expect(self.cartManager.items.count).to(equal(0))
        
        cartManager.addItemToCart(item: createExampleItem(num: 0))
            
        expect(self.cartManager.items.count).to(equal(1))
    }
    
    func testRemoveItemFromCart() {
        let item = createExampleItem(num: 0)
        cartManager.addItemToCart(item: item)
        expect(self.cartManager.items.count).to(equal(1))
        cartManager.removeItemFromCart(item: item)
        expect(self.cartManager.items.count).to(equal(0))
    }
    
    func testGetSumPrice() {
        cartManager.addItemToCart(item: createExampleItem(num: 0, price: 10))
        cartManager.addItemToCart(item: createExampleItem(num: 0, price: 20))
        cartManager.addItemToCart(item: createExampleItem(num: 0, price: 30))
        expect(self.cartManager.getSumPrice()).to(equal(60))
    }
    
    func testPostCart() {
        cartManager.addItemToCart(item: createExampleItem(num: 0))
        _ = self.cartManager.postCart().then { _ -> Void in
            
        }.catch(execute: { (error) in
            XCTFail("Post fail")
        })
    }
    
    private struct ExampleItem: ShoppableItem {
        var associatedObject: AnyObject
        var cartId: String
        var name: String
        var price: Double
    }
    
    private func createExampleItem(num: Int, price: Double = 0.0) -> ExampleItem {
        return ExampleItem(associatedObject: DrinkModel(id: num, price: 0, name: ""),
                    cartId: UUID().uuidString,
                    name: "Example drink num",
                    price: price)
    }
}
