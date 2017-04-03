//
//  StorageTests.swift
//  Nennos pizza
//
//  Created by Bence Pattogato on 03/04/17.
//  Copyright © 2017 bence.pattogato. All rights reserved.
//

import XCTest
import Nimble

class StorageTests: XCTestCase {
    
    private var drinkStorage: DrinkStorageProtocol!
    private var pizzaStorage: PizzaStorageProtocol!
    private var ingredientStorage: IngredientStorageProtocol!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        drinkStorage = DIManager.resolve(service: DrinkStorageProtocol.self)
        pizzaStorage = DIManager.resolve(service: PizzaStorageProtocol.self)
        ingredientStorage = DIManager.resolve(service: IngredientStorageProtocol.self)
    }
    
    func testFetchDrinks() {
        var drinks = [DrinkModel]()
        _ = drinkStorage.getDrinks().then(execute: { (newDrinks) -> Void in
            drinks = newDrinks
        })
        expect(drinks.count).toEventuallyNot(equal(0), timeout: TestContsants.networkTimeout)
    }
    
    func testFetchPizzas() {
        var pizzas = [PizzaModel]()
        _ = pizzaStorage.getPizzas().then(execute: { (newPizzas) -> Void in
            pizzas = newPizzas
        })
        expect(pizzas.count).toEventuallyNot(equal(0), timeout: TestContsants.networkTimeout)
    }
    
    func testFetchIngredients() {
        var ingredients = [IngredientModel]()
        _ = ingredientStorage.getIngredients().then(execute: { (newIndgredients) -> Void in
            ingredients = newIndgredients
        })
        expect(ingredients.count).toEventuallyNot(equal(0), timeout: TestContsants.networkTimeout)
    }
    
    func testGetIngredientById() {
        _ = ingredientStorage.getIngredients().then(execute: { (ingredients) -> Void in
            let firstIngredient = self.ingredientStorage.getIngredientsFor(ids: [ingredients[0].id]).first
            expect(firstIngredient).to(equal(ingredients[0]))
        })
    }
    
}
