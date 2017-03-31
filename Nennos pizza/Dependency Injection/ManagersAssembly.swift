//
//  ManagersAssembly.swift
//  Nennos pizza
//
//  Created by Bence Pattogato on 28/03/17.
//  Copyright © 2017 bence.pattogato. All rights reserved.
//

import Foundation
import Swinject

final class ManagersAssembly: Assembly {
    
    func assemble(container: Container) {
        
        // Resolve application router
        container.register(ApplicationRouterProtocol.self) { resolver in
            var storyboards: [Storyboards: UIStoryboard] = [:]
            for storyboard in Storyboards.all() {
                storyboards[storyboard] = resolver.resolve(UIStoryboard.self, name: storyboard.name)
            }
            
            return ApplicationRouter(window: resolver.resolve(UIWindow.self)!,
                                     storyboards: storyboards)
        }.inObjectScope(.container)
        
        // Resolve cartmanager
        container.register(CartManagerProtocol.self) { r in
            return CartManager()
        }
    
    }
    
    

}
