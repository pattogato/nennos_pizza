//
//  PersistanceManager.swift
//  Nennos pizza
//
//  Created by Bence Pattogato on 03/04/17.
//  Copyright © 2017 bence.pattogato. All rights reserved.
//

import Foundation

protocol PersistanceManagerProtocol {
    func saveCartItems(items: [ShoppableItem])
    func getSavedItems() -> [ShoppableItem]?
}

final class PersistanceManager: PersistanceManagerProtocol {
    
    private let cartKey = "cartPersistantKey"
    
    private var defaults: UserDefaults {
        return .standard
    }
    
    func saveCartItems(items: [ShoppableItem]) {
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: items)
        defaults.set(encodedData, forKey: cartKey)
        defaults.synchronize()
    }
    
    func getSavedItems() -> [ShoppableItem]? {
        if let decoded = defaults.object(forKey: cartKey) as? Data {
            return NSKeyedUnarchiver.unarchiveObject(with: decoded) as? [ShoppableItem]
        }
        return nil
    }
    
}
