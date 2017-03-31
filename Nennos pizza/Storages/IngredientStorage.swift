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
}

final class InMemoryIngredientStorage: IngredientStorageProtocol {
    
    var service: ServicesProtocol!
    
    private var ingredients: [IngredientModel]? = nil
    
    func getIngredients() -> Promise<[IngredientModel]> {
        guard let ingredients = self.ingredients else {
            // If not loaded yet download them
            return service.getIngredients().then { ingredients -> Promise<[IngredientModel]> in
                // Download network models and map them to stored model
                let ingredients = ingredients.map({ return IngredientModel(networkModel: $0) })
                self.ingredients = ingredients
                return Promise(value: ingredients)
            }
        }
        
        // Only return the cached ingredients
        return Promise(value: ingredients)
    }
    
}
