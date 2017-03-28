//
//  DIManager.swift
//  Nennos pizza
//
//  Created by Bence Pattogato on 28/03/17.
//  Copyright © 2017 bence.pattogato. All rights reserved.
//

import Foundation

import Foundation

import Swinject
import SwinjectStoryboard

final class DIManager {
    
    static let shared = DIManager()
    
    fileprivate let assembler = Assembler(container: SwinjectStoryboard.defaultContainer)
    
    private init() {
        // Register assemblys
        assembler.apply(assemblies: [
            ApplicationAssembly(),
            ManagersAssembly(),
            ServicesAssembly(),
            DataprovidersAssembly(),
            ])
    }
    
}

extension DIManager {
    /**
     Easy Access to the Application Resolver.
     Should be used to instantiate registered objects.
     
     Exsample usage:
     
     `ManagerProvider.ApplicationResolver.resolve(SomeProtocol.self)`
     */
    static var ApplicationResolver: Resolver {
        return shared.assembler.resolver
    }
    
    /**
     Easy access & resolve registered dependencies.
     
     Use the service parameter for explicit type declaration or leave it blank
     to resolve by the context.
     
     - returns: The requested resource.
     */
    class func resolve<T>(service: T.Type? = nil) -> T {
        return ApplicationResolver.resolve(T.self)!
    }
    
    /**
     Easy access & resolve registered dependencies.
     
     Retrieves the instance with the specified service type and registration name.
     
     - service: The service type to resolve.
     - name: The registration name.
     
     - returns: The resolved service type instance, or nil if no service with the
     name is found.
     */
    class func resolve<T>(service: T.Type, name: String?) -> T? {
        return ApplicationResolver.resolve(T.self, name: name)
    }
    
    class func resolve<Service, Arg1>(
        _ serviceType: Service.Type,
        argument: Arg1) -> Service? {
        return ApplicationResolver.resolve(Service.self, argument: argument)
    }
}
