//
//  DrinkMOdel.swift
//  Nennos pizza
//
//  Created by Bence Pattogato on 30/03/17.
//  Copyright © 2017 bence.pattogato. All rights reserved.
//

import Foundation
import ObjectMapper

final class DrinkModel  {
    
    var id: Int
    var price: Double
    var name: String
    
    init(id: Int, price: Double, name: String) {
        self.id = id
        self.price = price
        self.name = name
    }

    convenience init(networkModel: DrinkNetworkModel) {
        self.init(id: networkModel.id ?? -1,
                  price: networkModel.price ?? 0,
                  name: networkModel.name ?? "")
    }
    
    var viewModel: DrinkViewModelProtocol {
        return DrinkViewModel(name: self.name, price: self.price)
    }
}
