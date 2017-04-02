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
    func getPizzaPrice(pizza: PizzaModel) -> Double
}

final class InMemoryPizzaStorage: BaseInMemoryStorage<PizzaModel>, PizzaStorageProtocol {
    
    let ingredientStorage: IngredientStorageProtocol
    
    init(service: ServicesProtocol,
         ingredientStorage: IngredientStorageProtocol) {
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
    
    func getPizzaPrice(pizza: PizzaModel) -> Double {
        let ingredients = ingredientStorage.getIngredientsForPizza(model: pizza)
        var sum: Double = 0
        ingredients.forEach({ sum += $0.price })
        return basePrice + sum
    }
    
    override func getElements() -> Promise<[PizzaModel]> {
        guard let pizzas = self.storedElements else {
            // If not loaded yet download them
            return service.getPizzas().then { pizzaList -> Promise<[PizzaModel]> in
                // Download network models and map them to stored model
                let pizzas = pizzaList.pizzas?.map({ return PizzaModel(networkModel: $0, basePrice: pizzaList.basePrice ?? 0) })
                self.basePrice = pizzaList.basePrice ?? 0.0
                self.storedElements = pizzas
                return Promise(value: pizzas ?? [PizzaModel]())
            }
        }
        
        // Only return the cached ingredients
        return Promise(value: pizzas)
    }
    
}

