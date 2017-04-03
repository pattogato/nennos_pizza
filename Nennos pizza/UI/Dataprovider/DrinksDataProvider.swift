//
//  DrinksDataProvider.swift
//  Nennos pizza
//
//  Created by Bence Pattogato on 29/03/17.
//  Copyright © 2017 bence.pattogato. All rights reserved.
//

import Foundation
import PromiseKit

protocol DrinkViewModelProtocol {
    var name: String { get }
    var price: Double { get }
}

protocol DrinksDataProviderProtocol: AsyncLoadingDataProviderProtocol {
    func numberOfRows() -> Int
    func itemAt(indexPath: IndexPath) throws -> DrinkViewModelProtocol
    func addItemToCartAt(indexPath: IndexPath)
}

fileprivate struct DrinkViewModel: DrinkViewModelProtocol {
    var name: String
    var price: Double
    
    init(name: String, price: Double) {
        self.name = name
        self.price = price
    }
    
    init(model: DrinkModel) {
        self.name = model.name
        self.price = model.price
    }
}

final class DrinksDataProvider: DrinksDataProviderProtocol {
    
    let drinksStorage: DrinkStorageProtocol
    let cartManager: CartManagerProtocol
    
    var drinkModels: [DrinkModel]?
    
    init(drinksStorage: DrinkStorageProtocol,
         cartManager: CartManagerProtocol) {
        self.drinksStorage = drinksStorage
        self.cartManager = cartManager
    }
    
    func loadDataIfNeeded() -> Promise<Void> {
        if drinkModels != nil {
            return Promise { fulfill, reject in fulfill() }
        }
        return reloadData()
    }
    
    func reloadData() -> Promise<Void> {
        return drinksStorage.getDrinks().then(execute: { (drinkModels) -> Promise<Void> in
            self.drinkModels = drinkModels
            return Promise { fulfill, reject in fulfill() }
        })
    }
    
    func numberOfRows() -> Int {
        return drinkModels?.count ?? 0
    }
    
    func itemAt(indexPath: IndexPath) throws -> DrinkViewModelProtocol {
        guard let drinks = self.drinkModels else {
            throw DataProviderError.dataNotLoadedError
        }
        if indexPath.row > drinks.count + 1 {
            throw DataProviderError.indexOutOfBounds
        }
        return DrinkViewModel(model: drinks[indexPath.row])
    }
    
    func addItemToCartAt(indexPath: IndexPath) {
        if let drink = drinkModels?[indexPath.row] {
            cartManager.addItemToCart(item: drink)
        }
    }

}

final class MockedDrinksDataProvider: DrinksDataProviderProtocol {
    
    func numberOfRows() -> Int {
        return 6
    }
    
    func itemAt(indexPath: IndexPath) -> DrinkViewModelProtocol {
        return DrinkViewModel(name: "drink #\(indexPath.row)", price: Double(indexPath.row * 3))
    }
    
    func addItemToCartAt(indexPath: IndexPath) {
        print("add")
    }
    
    func loadDataIfNeeded() -> Promise<Void> {
        return Promise { fulfill, reject in fulfill() }
    }
    
    func reloadData() -> Promise<Void> {
        return Promise { fulfill, reject in fulfill() }
    }
}
