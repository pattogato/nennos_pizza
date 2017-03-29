//
//  MenuDataProvider.swift
//  Nennos pizza
//
//  Created by Bence Pattogato on 29/03/17.
//  Copyright © 2017 bence.pattogato. All rights reserved.
//

import UIKit

protocol MenuDataProviderProtocol {
    func numberOfRows() -> Int
    func itemAt(indexPath: IndexPath) -> MenuItemViewModelProtocol
    func addItemToCart(at indexPath: IndexPath)
}

final class MockedMenuDataProvider: MenuDataProviderProtocol {
    
    private struct MenuItemViewModel: MenuItemViewModelProtocol {
        var imageUrl: URL?
        var ingredients: String
        var price: Double
        var title: String
    }
    
    func numberOfRows() -> Int {
        return 20
    }
    
    func itemAt(indexPath: IndexPath) -> MenuItemViewModelProtocol {
        return MenuItemViewModel(imageUrl: URL(string: "https://cdn.pbrd.co/images/tOhJQ5N3.png")!,
                                 ingredients: arc4random() % 2 == 1 ? "Mozarella, tomato sauce, salami, pepperoni, mushroom, ricci" : "Mozarella, tomato sauce",
                                 price: Double(indexPath.row * 4),
                                 title: "Pizza #\(indexPath.row)")
    }
    
    func addItemToCart(at indexPath: IndexPath) {
        print("add to cart")
    }
}
