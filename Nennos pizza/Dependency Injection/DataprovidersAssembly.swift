//
//  DataprovidersAssemby.swift
//  Nennos pizza
//
//  Created by Bence Pattogato on 28/03/17.
//  Copyright © 2017 bence.pattogato. All rights reserved.
//

import Foundation
import Swinject


final class  DataprovidersAssembly: Assembly {
    
    func assemble(container: Container) {
        // Custom pizza
        container.register(CustomPizzaDataProviderProtocol.self) { r in
            return MockedCustomPizzaDataProviderProtocol()
        }
        
        // Menu
        container.register(MenuDataProviderProtocol.self) { r in
            return MenuDataProvider(
                pizzaStorage: r.resolve(PizzaStorageProtocol.self)!,
                cartManager: r.resolve(CartManagerProtocol.self)!
            )
        }
        
        // Cart
        container.register(CartDataProviderProtocol.self) { r in
            return MockedCartDataProvider()
        }
        
        // Drinks
        container.register(DrinksDataProviderProtocol.self) { r in
            return MockedDrinksDataProvider()
        }
    }
    
}
