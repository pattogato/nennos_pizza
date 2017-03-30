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
    
}

final class InMemoryIngredientStorage: IngredientStorageProtocol {
    
    var service: ServicesProtocol!
    
    private var ingredients: [IngredientModel]? = nil
    
    func getIngredients() -> Promise<IngredientModel> {
        if ingredients == nil {
            // If not loaded yet download them
//            service.getIngredients().then { ingredients -> Promise<IngredientModel> in
//                self.ingredients = ingredients.mapping(
//            })
        } else {
            // Only return the cached ingredients
        }
    }
    
}
