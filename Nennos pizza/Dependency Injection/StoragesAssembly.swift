//
//  StoragesAssembly.swift
//  Nennos pizza
//
//  Created by Bence Pattogato on 28/03/17.
//  Copyright © 2017 bence.pattogato. All rights reserved.
//

import Foundation
import Swinject

final class StoragesAssembly: Assembly {
    
    func assemble(container: Container) {
        // Resolve ingredient storage protocol with inMemory implementation
        // With the objectscope .container it will be singleton
        container.register(IngredientStorageProtocol.self) { r in
            return InMemoryIngredientStorage(service: r.resolve(ServicesProtocol.self)!)
        }.inObjectScope(.container)
        
        // Resolve pizza storage protocol with inMemory implementation
        container.register(PizzaStorageProtocol.self) { r in
            return InMemoryPizzaStorage(
                service: r.resolve(ServicesProtocol.self)!,
                ingredientStorage: r.resolve(IngredientStorageProtocol.self)!
            )
        }.inObjectScope(.container)
        
        // Resolve drink storage protocol with inMemory implementation
        container.register(DrinkStorageProtocol.self) { r in
            return InMemoryDrinkStorage(service: r.resolve(ServicesProtocol.self)!)
        }.inObjectScope(.container)
    }
    
}
