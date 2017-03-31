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
}

enum ServiceError: Error {
    case unknownError
}

final class Services: ServicesProtocol {
    
    func getIngredients() -> Promise<[IngredientNetworkModel]> {
        
        let promise: Promise<[IngredientNetworkModel]> = Promise {
            fulfill, reject in
            
            return makeRequest(serviceResource: .getIngredients)?.responseArray { (response: DataResponse<[IngredientNetworkModel]>) in
                
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
    
    
    
}

extension Services {
    fileprivate func makeRequest(serviceResource: ServiceResource) -> DataRequest? {
        if let url = serviceResource.url {
            return Alamofire.request(url, method: serviceResource.httpMethod)
        }
        assertionFailure("Url is invalid \(serviceResource.httpMethod)")
        return nil
    }
}
