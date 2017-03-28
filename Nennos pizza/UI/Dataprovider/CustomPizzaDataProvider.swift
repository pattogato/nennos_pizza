//
//  CustomPizzaDataProvider.swift
//  Nennos pizza
//
//  Created by Bence Pattogato on 27/03/17.
//  Copyright © 2017 bence.pattogato. All rights reserved.
//

import Foundation

protocol CustomPizzaDataProviderProtocol {
    func numberOfRows() -> Int
    func modelFor(indexPath: IndexPath) -> IngredientViewModel
    func isModelSelected(indexPath: IndexPath) -> Bool
    func selecItemAt(indexPath: IndexPath)
    func deSelecItemAt(indexPath: IndexPath)
}

final class MockedCustomPizzaDataProviderProtocol {
    
}
