//
//  ServiceResources.swift
//  Nennos pizza
//
//  Created by Bence Pattogato on 29/03/17.
//  Copyright © 2017 bence.pattogato. All rights reserved.
//

import Foundation
import Alamofire

fileprivate struct Constants {
    static let baseUrl = "http://beta.json-generator.com/api/json/"
}

enum ParameterNames {
    case drinks
    case pizzas
    
    var name: String {
        switch self {
        case .drinks:
            return "drinks"
        case .pizzas:
            return "pizzas"
        }
    }
}

enum ServiceResource {
    
    case getIngredients
    case getDrinks
    case getPizzas
    case postCart
    
    private var additionalUrl: String {
        switch self {
        case .getIngredients:
            return "get/EkTFDCdsG"
        case .getDrinks:
            return "get/N1mnOA_oz"
        case .getPizzas:
            return "get/NybelGcjz"
        case .postCart:
            return ""
        }
    }
    
    var url: URL? {
        switch self {
        case .getIngredients, .getDrinks, .getPizzas:
            return URL(string: Constants.baseUrl + self.additionalUrl)
        case .postCart:
            return URL(string: "http://posttestserver.com/post.php")
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getIngredients, .getDrinks, .getPizzas:
            return .get
        case .postCart:
            return .post
        }
    }
}
