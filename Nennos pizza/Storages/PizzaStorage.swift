//
//  PizzaStorage.swift
//  Nennos pizza
//
//  Created by Bence Pattogato on 31/03/17.
//  Copyright © 2017 bence.pattogato. All rights reserved.
//

import Foundation
import PromiseKit

protocol PizzaStorageProtocol {
    func getPizzas() -> Promise<[PizzaModel]>
    func getBasePrice() -> Double
    
}

final class InMemoryPizzaStorage: BaseInMemoryStorage<PizzaModel>, PizzaStorageProtocol {
    
    let ingredientStorage: IngredientStorageProtocol
    
    init(service: ServicesProtocol, ingredientStorage: IngredientStorageProtocol) {
        self.ingredientStorage = ingredientStorage
        super.init(service: service)
    }
    
    private var basePrice: Double = 0.0
    
    func getBasePrice() -> Double {
        return basePrice
    }
    
    func getPizzas() -> Promise<[PizzaModel]> {
        return getElements()
    }
    
    override func getElements() -> Promise<[PizzaModel]> {
        // First need to get ingredients, to load Ingredient models to Pizza models
        // based on ids
        guard let pizzas = self.storedElements else {
            return ingredientStorage.getIngredients().then { (ingredients) -> Promise<[PizzaModel]> in
                // If not loaded yet download them
                return self.service.getPizzas().then { pizzaList -> Promise<[PizzaModel]> in
                    // Download network models and map them to stored model
                    let pizzas = pizzaList.pizzas?.map({ (pizzaNetworkModel) -> PizzaModel in
                        let pizzaModel = PizzaModel(networkModel: pizzaNetworkModel,
                                                    basePrice: pizzaList.basePrice ?? 0)
                        // Get ingredient models from ids
                        if let ingredientIds = pizzaNetworkModel.ingredients {
                            pizzaModel.ingredients = self.ingredientStorage.getIngredientsFor(ids: ingredientIds)
                        }
                        return pizzaModel
                    })
                    self.basePrice = pizzaList.basePrice ?? 0.0
                    self.storedElements = pizzas
                    return Promise(value: pizzas ?? [PizzaModel]())
                }
            }
        }
        
        // Only return the cached ingredients
        return Promise(value: pizzas)
    }
    
    
}

