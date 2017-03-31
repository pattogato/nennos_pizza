//
//  DrinkStorage.swift
//  Nennos pizza
//
//  Created by Bence Pattogato on 31/03/17.
//  Copyright © 2017 bence.pattogato. All rights reserved.
//

import Foundation
import PromiseKit

protocol DrinkStorageProtocol {
    func getDrinks() -> Promise<[DrinkModel]>
}

final class InMemoryDrinkStorage: BaseInMemoryStorage<DrinkModel>, DrinkStorageProtocol {
    
    func getDrinks() -> Promise<[DrinkModel]> {
        return getElements()
    }
    
    override func getElements() -> Promise<[DrinkModel]> {
        guard let drinks = self.storedElements else {
            // If not loaded yet download them
            return service.getDrinks().then { drinks -> Promise<[DrinkModel]> in
                // Download network models and map them to stored model
                let drinks = drinks.map({ return DrinkModel(networkModel: $0) })
                self.storedElements = drinks
                return Promise(value: drinks)
            }
        }
        
        // Only return the cached drinks
        return Promise(value: drinks)
    }
    
}
