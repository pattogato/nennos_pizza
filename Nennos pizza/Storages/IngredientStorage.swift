//
//  IngredientStorage.swift
//  Nennos pizza
//
//  Created by Bence Pattogato on 30/03/17.
//  Copyright © 2017 bence.pattogato. All rights reserved.
//

import Foundation
import PromiseKit

protocol IngredientStorageProtocol {
    func getIngredients() -> Promise<[IngredientModel]>
    func getIngredientForId(id: Int) throws -> IngredientModel?
    func getIngredientsForPizza(model: PizzaModel) -> [IngredientModel]
}

final class InMemoryIngredientStorage: BaseInMemoryStorage<IngredientModel>, IngredientStorageProtocol {
    
    func getIngredients() -> Promise<[IngredientModel]> {
        return getElements()
    }
    
    func getIngredientForId(id: Int) throws -> IngredientModel? {
        guard let ingredients = self.storedElements else {
            throw DataProviderError.dataNotLoadedError
        }
        return ingredients.filter({ $0.id == id }).first
    }
    
    func getIngredientsForPizza(model: PizzaModel) -> [IngredientModel] {
        
        var ingredientModelForPizza = [IngredientModel]()
        // Get ingredients from ingredient ids
        if let ingredientIds = model.ingredientIds {
            ingredientIds.forEach({ (id) in
                do {
                    if let ingredientModel = try self.getIngredientForId(id: id) {
                        ingredientModelForPizza.append(ingredientModel)
                    }
                } catch {
                    print("items not loaded")
                }
            })
        }
        
        return ingredientModelForPizza
    }
    
    override func getElements() -> Promise<[IngredientModel]> {
        guard let ingredients = self.storedElements else {
            // If not loaded yet download them
            return service.getIngredients().then { ingredients -> Promise<[IngredientModel]> in
                // Download network models and map them to stored model
                let ingredients = ingredients.map({ return IngredientModel(networkModel: $0) })
                self.storedElements = ingredients
                return Promise(value: ingredients)
            }
        }
        
        // Only return the cached ingredients
        return Promise(value: ingredients)
    }
    
}
