//
//  Services.swift
//  Nennos pizza
//
//  Created by Bence Pattogato on 29/03/17.
//  Copyright © 2017 bence.pattogato. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper
import PromiseKit
import ObjectMapper

protocol ServicesProtocol {
    func getIngredients() -> Promise<[IngredientNetworkModel]>
    func getPizzas() -> Promise<PizzaListNetworkModel>
    func getDrinks() -> Promise<[DrinkNetworkModel]>
}

enum ServiceError: Error {
    case unknownError
}

final class Services: ServicesProtocol {
    
    /**
     Download and parse ingredients
     */
    func getIngredients() -> Promise<[IngredientNetworkModel]> {
        return getModelArray(serviceResource: .getIngredients)
    }
    
    /**
     Download and parse pizzas
     */
    func getPizzas() -> Promise<PizzaListNetworkModel> {
        return getModel(serviceResource: .getPizzas)
    }
    
    /**
     Download and parse drinks
     */
    func getDrinks() -> Promise<[DrinkNetworkModel]> {
        return getModelArray(serviceResource: .getDrinks)
    }
    
}

extension Services {
    /**
     Executes a network call & parses the response array with the given generic type
     
     - Parameters:
     - MappableModel: a class conforming to Mappable protocol, this class will be used during the mapping
     - serviceResouce: The given enum case with the network call's parameters
     
     - Returns: generic promise with the MappableModel type array
     */
    fileprivate func getModelArray<MappableModel: Mappable>(serviceResource: ServiceResource) -> Promise<[MappableModel]> {
        let promise: Promise<[MappableModel]> = Promise {
            fulfill, reject in
            
            return makeRequest(serviceResource: serviceResource)?.responseArray { (response: DataResponse<[MappableModel]>) in
                
                if let result = response.result.value {
                    fulfill(result)
                } else if let error = response.result.error {
                    reject(error)
                } else {
                    reject(ServiceError.unknownError)
                }
            }
        }
        
        return promise
    }
    
    /**
     Executes a network call & parses the response with the given generic type
     
     - Parameters:
     - MappableModel: a class conforming to Mappable protocol, this class will be used during the mapping
     - serviceResouce: The given enum case with the network call's parameters
     
     - Returns: generic promise with the MappableModel type object
     */
    fileprivate func getModel<MappableModel: Mappable>(serviceResource: ServiceResource) -> Promise<MappableModel> {
        let promise: Promise<MappableModel> = Promise {
            fulfill, reject in
            
            return makeRequest(serviceResource: serviceResource)?.responseObject { (response: DataResponse<MappableModel>) in
                
                if let result = response.result.value {
                    fulfill(result)
                } else if let error = response.result.error {
                    reject(error)
                } else {
                    reject(ServiceError.unknownError)
                }
            }
        }
        
        return promise
    }
    
    /**
     Create an alamofire request
     
     - Parameters:
     - sericeResource: The given enum case with the network call's parameters
     
     - Returns: Executable DataRequest
     */
    fileprivate func makeRequest(serviceResource: ServiceResource) -> DataRequest? {
        if let url = serviceResource.url {
            return Alamofire.request(url, method: serviceResource.httpMethod)
        }
        assertionFailure("Url is invalid \(serviceResource.httpMethod)")
        return nil
    }
}
