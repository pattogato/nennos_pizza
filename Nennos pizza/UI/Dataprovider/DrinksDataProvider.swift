//
//  DrinksDataProvider.swift
//  Nennos pizza
//
//  Created by Bence Pattogato on 29/03/17.
//  Copyright © 2017 bence.pattogato. All rights reserved.
//

import Foundation

protocol DrinksDataProviderProtocol {
    func numberOfRows() -> Int
    func itemAt(indexPath: IndexPath) -> DrinkViewModelProtocol
    func addItemToCartAt(indexPath: IndexPath)
}

struct DrinkViewModel: DrinkViewModelProtocol {
    var name: String
    var price: Double
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
}
