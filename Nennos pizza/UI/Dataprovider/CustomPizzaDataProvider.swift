//
//  CustomPizzaDataProvider.swift
//  Nennos pizza
//
//  Created by Bence Pattogato on 27/03/17.
//  Copyright © 2017 bence.pattogato. All rights reserved.
//

import UIKit
import PromiseKit

protocol IngredientViewModelProtocol {
    var name: String { get }
    var price: Double { get }
}

protocol CustomPizzaDataProviderProtocol: AsyncLoadingDataProviderProtocol {
    // For tableview
    func numberOfRows() -> Int
    func modelFor(indexPath: IndexPath) throws -> IngredientViewModelProtocol
    func selectedItems() -> [IndexPath]
    func selecItemAt(indexPath: IndexPath)
    func deSelecItemAt(indexPath: IndexPath)
    // Getters
    func getPizzaImageUrl() -> URL?
    func getSumPrice() -> Double
    func getTitle() -> String
    func addPizzaToCart() -> Bool
    // Setters
    func setPizza(pizzaModel: PizzaModel)
    // Properties
    var isAddToCartButtonEnabled: Bool { get }
    var delegate: CustomPizzaDataProviderDelegate? { get set }
    var isCreateMode: Bool { get }
}

protocol CustomPizzaDataProviderDelegate: class {
    func refreshSumPrice(price: Double)
}

final class CustomPizzaDataProvider: CustomPizzaDataProviderProtocol {
    
    weak var delegate: CustomPizzaDataProviderDelegate?
    
    // Dependencies
    let ingredientStorage: IngredientStorageProtocol
    // Need to get the base pizza price
    let pizzaStorage: PizzaStorageProtocol
    let cartManager: CartManagerProtocol
    
    // Properties
    var ingredients: [IngredientModel]?
    var selectedIngredients = [IngredientModel]()
    private var basePrice: Double = Double.greatestFiniteMagnitude
    
    // Init
    init(ingredientStorage: IngredientStorageProtocol,
         cartManager: CartManagerProtocol,
         pizzaStorage: PizzaStorageProtocol) {
        self.ingredientStorage = ingredientStorage
        self.cartManager = cartManager
        self.pizzaStorage = pizzaStorage
    }
    
    // Store here the set pizza model if there is
    private var pizza: PizzaModel?
    
    // Protocol methods and properties
    var isCreateMode: Bool {
        return pizza == nil
    }
    
    var isAddToCartButtonEnabled: Bool {
        // TODO: Implement
        return true
    }
    
    // MARK: Tableview methods
    func numberOfRows() -> Int {
        return ingredients?.count ?? 0
    }
    
    func modelFor(indexPath: IndexPath) throws -> IngredientViewModelProtocol {
        guard let ingredients = self.ingredients else {
            throw DataProviderError.dataNotLoadedError
        }
        if indexPath.row > ingredients.count + 1 {
            throw DataProviderError.indexOutOfBounds
        }
        return IngredientViewModel(ingredientModel: ingredients[indexPath.row])
    }
    
    func selectedItems() -> [IndexPath] {
        var indexPaths = [IndexPath]()
        guard let ingredients = self.ingredients else {
            return indexPaths
        }
        for (index,ingredient) in ingredients.enumerated() {
            if selectedIngredients.contains(ingredient) {
                indexPaths.append(IndexPath(row: index, section: 0))
            }
        }
        
        return indexPaths
    }
    
    func selecItemAt(indexPath: IndexPath) {
        guard let ingredientToSelect = ingredients?[indexPath.row] else {
            return
        }
        selectedIngredients.append(ingredientToSelect)
        refreshSumPrice()
    }
    
    func deSelecItemAt(indexPath: IndexPath) {
        guard let ingredientToRemove = ingredients?[indexPath.row] else {
            return
        }
        selectedIngredients = selectedIngredients.filter({ $0 != ingredientToRemove })
        refreshSumPrice()
    }
    
    // MARK: Getters
    func getPizzaImageUrl() -> URL? {
        return pizza?.imageUrl
    }
    
    func getSumPrice() -> Double {
        var sum: Double = 0
        selectedIngredients.forEach({ sum += $0.price })
        return basePrice + sum
    }
    
    func getTitle() -> String {
        if isCreateMode {
            return "custom.create.title".localized
        } else {
            return pizza?.name.uppercased() ?? ""
        }
    }
    
    func addPizzaToCart() -> Bool {
        if let pizza = getCustomPizza() {
            cartManager.addItemToCart(item: pizza)
            return true
        }
        return false
    }
    
    private func getCustomPizza() -> PizzaModel? {
        
        // Returns the name of the pizza
        func getName() -> String {
            return "Custom " + (isCreateMode ? "pizza" : (pizza?.name ?? ""))
        }
        
        // If the user didn't change the original pizza, return that
        if !isCreateMode && selectedIngredients ~= (pizza?.ingredients ?? [IngredientModel]()) {
            return pizza
        }

        assert(basePrice != Double.greatestFiniteMagnitude, "Base price must be set")
        guard selectedIngredients.count > 0 else {
            return nil
        }

        return PizzaModel(basePrice: basePrice,
                          name: getName(),
                          ingredients: selectedIngredients,
                          imageUrl: pizza?.imageUrl)
    }
    
    // MARK: Setters
    func setPizza(pizzaModel: PizzaModel) {
        self.pizza = pizzaModel
    }
    
    // MARK: Loading methods
    func loadDataIfNeeded() -> Promise<Void> {
        if self.ingredients != nil {
            return Promise { fulfill, reject in fulfill() }
        }
        return reloadData()
    }
    
    func reloadData() -> Promise<Void> {
        return pizzaStorage.getPizzas().then { (_) -> Promise<Void> in
            return self.ingredientStorage.getIngredients().then { (ingredients) -> Promise<Void> in
                self.ingredients = ingredients
                self.addSelectedItemsIfNeeded()
                self.basePrice = self.pizzaStorage.getBasePrice()
                // Return empty promise
                return Promise { fulfill, reject in fulfill() }
            }
        }
    }
    
    
    // MARK: private functions
    
    private func refreshSumPrice() {
        delegate?.refreshSumPrice(price: self.getSumPrice())
    }
    
    private func addSelectedItemsIfNeeded() {
        if let ingredients = self.pizza?.ingredients {
            selectedIngredients = ingredients
        }
    }
}

/**
 Returns mocked data for testing
 */
final class MockedCustomPizzaDataProviderProtocol: CustomPizzaDataProviderProtocol {
    
    internal var isCreateMode: Bool {
        return true
    }
    
    weak var delegate: CustomPizzaDataProviderDelegate?
    
    private var selectedIndexPaths = [IndexPath]()
    
    func setPizza(pizzaModel: PizzaModel) {
        // MOCK
    }
    
    func numberOfRows() -> Int {
        return 15
    }
    
    func modelFor(indexPath: IndexPath) throws -> IngredientViewModelProtocol {
        return IngredientViewModel(
            name: "model \(indexPath.row)",
            price: Double(indexPath.row))
    }
    
    func isModelSelected(indexPath: IndexPath) -> Bool {
        return selectedIndexPaths.contains(indexPath)
    }
    
    func selecItemAt(indexPath: IndexPath) {
        selectedIndexPaths.append(indexPath)
        delegate?.refreshSumPrice(price: self.getSumPrice())
    }
    
    func deSelecItemAt(indexPath: IndexPath) {
        selectedIndexPaths = selectedIndexPaths.filter({ $0 != indexPath })
        delegate?.refreshSumPrice(price: self.getSumPrice())
    }
    
    func getPizzaImageUrl() -> URL? {
        return URL(string: "https://cdn.pbrd.co/images/tOhJQ5N3.png")
    }
    
    var isAddToCartButtonEnabled: Bool {
        return selectedIndexPaths.count != 0
    }
    
    func getSumPrice() -> Double {
        var sumPrice: Double = 0
        selectedIndexPaths.forEach({ sumPrice += try! modelFor(indexPath: $0).price })
        // TODO: Currency should be properly handled
        return sumPrice
    }
    
    func loadDataIfNeeded() -> Promise<Void> {
        return Promise { fulfill, reject in fulfill() }
    }
    
    func reloadData() -> Promise<Void> {
        return Promise { fulfill, reject in fulfill() }
    }
    
    func getTitle() -> String {
        return "Mock title"
    }
    
    func addPizzaToCart() -> Bool {
        return true
    }
    
    func selectedItems() -> [IndexPath] {
        return [IndexPath]()
    }
}

struct IngredientViewModel: IngredientViewModelProtocol {
    var name: String
    var price: Double
    
    init(name: String, price: Double) {
        self.name = name
        self.price = price
    }
    
    init(ingredientModel: IngredientModel) {
        self.name = ingredientModel.name
        self.price = ingredientModel.price
    }
}
