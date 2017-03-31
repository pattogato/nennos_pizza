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
}

final class InMemoryPizzaStorage: PizzaStorageProtocol {
    
    let service: ServicesProtocol
    
    init(service: ServicesProtocol) {
        self.service = service
    }
    
    private var pizzas: [PizzaModel]? = nil
    
    func getPizzas() -> Promise<[PizzaModel]> {
        guard let pizzas = self.pizzas else {
            // If not loaded yet download them
            return service.getPizzas().then { pizzaList -> Promise<[PizzaModel]> in
                // Download network models and map them to stored model
                let pizzas = pizzaList.pizzas?.map({ return PizzaModel(networkModel: $0, basePrice: pizzaList.basePrice ?? 0) })
                self.pizzas = pizzas
                return Promise(value: pizzas ?? [PizzaModel]())
            }
        }
        
        // Only return the cached ingredients
        return Promise(value: pizzas)
    }
    
}
