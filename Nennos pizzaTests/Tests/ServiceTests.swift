//
//  ServiceTests.swift
//  Nennos pizza
//
//  Created by Bence Pattogato on 03/04/17.
//  Copyright © 2017 bence.pattogato. All rights reserved.
//

import XCTest
import Nimble

class ServiceTests: XCTestCase {
    
    private var services: ServicesProtocol!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        services = DIManager.resolve(service: ServicesProtocol.self)
    }
    
    func testParseGetDrinksNetworkResponse() {
//        var drinkNetworkModel: DrinkNetworkModel?
//        _ = services.getDrinks().then { drinks -> Void in
//            drinkNetworkModel = drinks[0]
//        }
//        expect(drinkNetworkModel?.name).toNotEventually(equal(nil), timeout: TestContsants.networkTimeout)
//        expect(drinkNetworkModel?.price).toNotEventually(equal(nil), timeout: TestContsants.networkTimeout)
//        expect(drinkNetworkModel?.id).toNotEventually(equal(nil), timeout: TestContsants.networkTimeout)
    }
    
    func testParseGetPizzasNetworkResponse() {
//        var pizzaNetworkModel: PizzaNetworkModel?
//        var basePrice: Double?
//        _ = services.getPizzas().then { (pizzaRepsonse) -> Void in
//            pizzaNetworkModel = pizzaRepsonse.pizzas?[0]
//            basePrice = pizzaRepsonse.basePrice
//        }
//        expect(basePrice).toNotEventually(equal(nil), timeout: TestContsants.networkTimeout)
//        expect(pizzaNetworkModel?.name).toNotEventually(equal(nil), timeout: TestContsants.networkTimeout)
//        expect(pizzaNetworkModel?.ingredients).toNotEventually(equal(nil), timeout: TestContsants.networkTimeout)
        // Image url is optional
    }
    
    func testParseGetIngredientsNetworkResponse() {
//        var ingredientNetworkModel: IngredientNetworkModel?
//        _ = services.getIngredients().then(execute: { (ingredients) -> Void in
//            ingredientNetworkModel = ingredients[0]
//        })
//        expect(ingredientNetworkModel?.price).toNotEventually(equal(nil), timeout: TestContsants.networkTimeout)
//        expect(ingredientNetworkModel?.name).toNotEventually(equal(nil), timeout: TestContsants.networkTimeout)
//        expect(ingredientNetworkModel?.id).toNotEventually(equal(nil), timeout: TestContsants.networkTimeout)
    }
    
}
