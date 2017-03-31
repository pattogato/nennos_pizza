//
//  MenuDataProvider.swift
//  Nennos pizza
//
//  Created by Bence Pattogato on 29/03/17.
//  Copyright © 2017 bence.pattogato. All rights reserved.
//

import UIKit
import PromiseKit

protocol MenuDataProviderProtocol: AsyncLoadingDataProviderProtocol {
    func numberOfRows() -> Int
    func itemAt(indexPath: IndexPath) throws -> MenuItemViewModelProtocol
    func addItemToCart(at indexPath: IndexPath)
    func getModelAt(indexPath: IndexPath) throws -> PizzaModel
}

final class MenuDataProvider: MenuDataProviderProtocol {
    
    let pizzaStorage: PizzaStorageProtocol
    let cartManager: CartManagerProtocol
    
    private var pizzas: [PizzaModel]?
    
    init(pizzaStorage: PizzaStorageProtocol, cartManager: CartManagerProtocol) {
        self.pizzaStorage = pizzaStorage
        self.cartManager = cartManager
    }
    
    func loadData() -> Promise<Bool> {
        return pizzaStorage.getPizzas().then(execute: { (pizzas) -> Promise<Bool> in
            self.pizzas = pizzas
            
            return Promise(value: true)
        })
    }
    
    func numberOfRows() -> Int {
        return pizzas?.count ?? 0
    }
    
    func itemAt(indexPath: IndexPath) throws -> MenuItemViewModelProtocol {
        guard let pizzas = self.pizzas else {
            throw DataProviderError.dataNotLoadedError
        }
        if indexPath.row > pizzas.count + 1 {
            throw DataProviderError.indexOutOfBounds
        }
        return MenuItemViewModel(model: pizzas[indexPath.row])
    }
    
    func getModelAt(indexPath: IndexPath) throws -> PizzaModel {
        guard let pizzas = self.pizzas else {
            throw DataProviderError.dataNotLoadedError
        }
        if indexPath.row > pizzas.count + 1 {
            throw DataProviderError.indexOutOfBounds
        }
        return pizzas[indexPath.row]
    }
    
    func addItemToCart(at indexPath: IndexPath) {
        // TODO: call this method
//        cartManager.addItemToCart(item: <#T##ShoppableItem#>)
    }
    
}

/**
 Returns dummy data for testing
 */
final class MockedMenuDataProvider: MenuDataProviderProtocol {
    
    func loadData() -> Promise<Bool> {
        return Promise(value: true)
    }
    
    func numberOfRows() -> Int {
        return 20
    }
    
    func itemAt(indexPath: IndexPath) throws -> MenuItemViewModelProtocol {
        return MenuItemViewModel(imageUrl: URL(string: "https://cdn.pbrd.co/images/tOhJQ5N3.png")!,
                                 ingredients: arc4random() % 2 == 1 ? "Mozarella, tomato sauce, salami, pepperoni, mushroom, ricci" : "Mozarella, tomato sauce",
                                 price: Double(indexPath.row * 4),
                                 title: "Pizza #\(indexPath.row)")
    }
    
    func getModelAt(indexPath: IndexPath) throws -> PizzaModel {
        return PizzaModel(basePrice: 15, name: "Mocked pizza", ingredientIds: nil, imageUrl: nil)
    }
    
    func addItemToCart(at indexPath: IndexPath) {
        print("add to cart")
    }
}

fileprivate struct MenuItemViewModel: MenuItemViewModelProtocol {
    var imageUrl: URL?
    var ingredients: String
    var price: Double
    var title: String
    
    init(imageUrl: URL?, ingredients: String, price: Double, title: String) {
        self.imageUrl = imageUrl
        self.ingredients = ingredients
        self.price = price
        self.title = title
    }

    
    init(model: PizzaModel) {
        self.imageUrl = model.imageUrl
        self.ingredients = "dummy ingredients"
//        self.ingredients = networkModel.ingredients
        self.price = model.basePrice
        self.title = model.name
        
    }
}
