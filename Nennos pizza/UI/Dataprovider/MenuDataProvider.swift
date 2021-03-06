//
//  MenuDataProvider.swift
//  Nennos pizza
//
//  Created by Bence Pattogato on 29/03/17.
//  Copyright © 2017 bence.pattogato. All rights reserved.
//

import UIKit
import PromiseKit

protocol MenuItemViewModelProtocol {
    var imageUrl: URL? { get }
    var title: String { get }
    var ingredients: String { get }
    var price: Double { get }
}

protocol MenuDataProviderProtocol: AsyncLoadingDataProviderProtocol {
    func numberOfRows() -> Int
    func itemAt(indexPath: IndexPath) throws -> MenuItemViewModelProtocol
    func addItemToCart(at indexPath: IndexPath)
    func getModelAt(indexPath: IndexPath) throws -> PizzaModel
}

final class MenuDataProvider: MenuDataProviderProtocol {
    
    let pizzaStorage: PizzaStorageProtocol
    // The ingredient storage needed, to exchange the ingredient ID-s to models
    let ingredientStorage: IngredientStorageProtocol
    let cartManager: CartManagerProtocol
    
    private var pizzas: [PizzaModel]?
    private var viewModels: [MenuItemViewModelProtocol]?
    
    init(pizzaStorage: PizzaStorageProtocol,
         cartManager: CartManagerProtocol,
         ingredientStorage: IngredientStorageProtocol) {
        self.pizzaStorage = pizzaStorage
        self.cartManager = cartManager
        self.ingredientStorage = ingredientStorage
    }
    
    func loadDataIfNeeded() -> Promise<Void> {
        if self.pizzas != nil {
            return Promise { fulfill, reject in fulfill() }
        }
        return reloadData()
    }
    
    func reloadData() -> Promise<Void> {
        // Load ingredients first
        return ingredientStorage.getIngredients().then { _ -> Promise<Void> in
            // Then load pizzas
            return self.pizzaStorage.getPizzas().then(execute: { (pizzas) -> Promise<Void> in
                self.pizzas = pizzas
                self.viewModels = self.createViewModelsFrom(pizzaModels: pizzas)
                return Promise { fulfill, reject in fulfill() }
            })
        }
    }
    
    func numberOfRows() -> Int {
        return viewModels?.count ?? 0
    }
    
    func itemAt(indexPath: IndexPath) throws -> MenuItemViewModelProtocol {
        guard let viewModels = self.viewModels else {
            throw DataProviderError.dataNotLoadedError
        }
        if indexPath.row > viewModels.count + 1 {
            throw DataProviderError.indexOutOfBounds
        }
        
        return viewModels[indexPath.row]
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
        do {
            cartManager.addItemToCart(item: try getModelAt(indexPath: indexPath))
        } catch {
            print("Item should be available at \(indexPath)")
        }
    }
    
    private func createViewModelsFrom(pizzaModels: [PizzaModel]) -> [MenuItemViewModelProtocol] {
        return pizzaModels.map({ return MenuItemViewModel(model: $0) })
    }
    
}

/**
 Returns dummy data for testing
 */
final class MockedMenuDataProvider: MenuDataProviderProtocol {
    
    func loadDataIfNeeded() -> Promise<Void> {
        return Promise { fulfill, reject in fulfill() }
    }
    
    func reloadData() -> Promise<Void> {
        return Promise { fulfill, reject in fulfill() }
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
        return PizzaModel(basePrice: 15, name: "Mocked pizza", ingredients: nil, imageUrl: nil)
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
        self.price = model.price
        self.title = model.name
        self.ingredients = ""
        self.ingredients = createIngredientsString(ingredientModels: model.ingredients ?? [IngredientModel]())
    }
    
    /**
     Constructs the ingredient string
     */
    func createIngredientsString(ingredientModels: [IngredientModel]) -> String {
        var retVal = ""
        for (index, ingredientModel) in ingredientModels.enumerated() {
            switch index {
            case 0:
                // First
                retVal += ingredientModel.name
            case ingredientModels.count - 1:
                // Last with dot at the end
                retVal += ingredientModel.name + "."
            default:
                // Rest separated with coma,lowercased
                retVal += ", " + ingredientModel.name.lowercased() + ", "
            }
        }
        return retVal
    }
}
