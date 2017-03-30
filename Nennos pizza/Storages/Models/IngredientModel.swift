//
//  IngredientModel.swift
//  Nennos pizza
//
//  Created by Bence Pattogato on 30/03/17.
//  Copyright © 2017 bence.pattogato. All rights reserved.
//

import Foundation

final class IngredientModel {
    
    var id: Int
    var price: Double
    var name: String
    
    init(id: Int, price: Double, name: String) {
        self.id = id
        self.price = price
        self.name = name
    }
    
    init(networkModel: IngredientNetworkModel) {
        self.id = networkModel.id ?? -1
        self.price = networkModel.price ?? 0
        self.name = networkModel.name ?? ""
    }
    
    var viewModel: IngredientViewModelProtocol {
        return IngredientViewModel(name: self.name, price: self.price)
    }
}
