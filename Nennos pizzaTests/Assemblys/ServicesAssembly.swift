//
//  ServicesAssembly.swift
//  Nennos pizza
//
//  Created by Bence Pattogato on 03/04/17.
//  Copyright © 2017 bence.pattogato. All rights reserved.
//

import Foundation
import Swinject

final class ServicesAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(ServicesProtocol.self) { r in
            return Services()
        }
        
    }
}
