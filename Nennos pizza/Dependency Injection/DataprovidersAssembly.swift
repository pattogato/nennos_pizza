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
        container.register(CustomPizzaDataProviderProtocol.self) { r in
            return MockedCustomPizzaDataProviderProtocol()
        }
        
        container.register(MenuDataProviderProtocol.self) { r in
            return MockedMenuDataProvider()
        }
        
        container.register(CartDataProviderProtocol.self) { r in
            return MockedCartDataProvider()
        }
    }
    
}
