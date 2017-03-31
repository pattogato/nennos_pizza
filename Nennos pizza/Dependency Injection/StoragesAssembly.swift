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
        // Resolve ingredient storage with inMemory implementation
        container.register(IngredientStorageProtocol.self) { r in
            return InMemoryIngredientStorage(service: r.resolve(ServicesProtocol.self)!)
        }
        
    }
    
}
