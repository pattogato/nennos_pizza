//
//  BaseInMemoryStorage.swift
//  Nennos pizza
//
//  Created by Bence Pattogato on 31/03/17.
//  Copyright © 2017 bence.pattogato. All rights reserved.
//

import Foundation
import ObjectMapper
import PromiseKit

class BaseInMemoryStorage<Type> {
    
    let service: ServicesProtocol
    
    init(service: ServicesProtocol) {
        self.service = service
    }
    
    // Has to be public, beacuse if its private, the inherited class cannot access it :(
    var storedElements: [Type]?
    
    func getElements() -> Promise<[Type]> {
        assertionFailure("Must be override by sublcass")
        return Promise(value: [Type]())
    }
    
    func wipe() {
        self.storedElements = nil
    }
    
}
