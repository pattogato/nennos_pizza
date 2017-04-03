//
//  ManagersAssembly.swift
//  Nennos pizza
//
//  Created by Bence Pattogato on 03/04/17.
//  Copyright © 2017 bence.pattogato. All rights reserved.
//

import Foundation
import Swinject

final class ManagersAssembly: Assembly {
    
    func assemble(container: Container) {
        // Resolve cartmanager
        container.register(CartManagerProtocol.self) { r in
            return CartManager(services: r.resolve(ServicesProtocol.self)!)
            }.inObjectScope(.container)
        
    }
    
    
    
}
