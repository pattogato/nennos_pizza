//
//  CartDataProvider.swift
//  Nennos pizza
//
//  Created by Bence Pattogato on 29/03/17.
//  Copyright © 2017 bence.pattogato. All rights reserved.
//

import Foundation

protocol CartDataProviderProtocol {
    func numberOfRows() -> Int
    func itemAt(indexPath: IndexPath) -> CartItemViewModelProtocol
    func deleteItemAt(indexPath: IndexPath)
    func sumPrice() -> Double
}

final class MockedCartDataProvider: CartDataProviderProtocol {
    
    private struct CartItemViewModel: CartItemViewModelProtocol {
        var price: Double
        var title: String
    }
    
    func numberOfRows() -> Int {
        return 9
    }
    
    func itemAt(indexPath: IndexPath) -> CartItemViewModelProtocol {
        return CartItemViewModel(price: Double(indexPath.row * 2),
                                 title: "element #\(indexPath.row)")
    }
    
    func deleteItemAt(indexPath: IndexPath) {
        // TODO: Implement
        print("delete")
    }
    
    func sumPrice() -> Double {
        return 66.0
    }
}

