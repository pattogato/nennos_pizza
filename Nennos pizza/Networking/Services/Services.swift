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

protocol ServicesProtocol {
    
}

final class Services: ServicesProtocol {
    
    func getIngredients() -> Promise<IngredientNetworkModel> {
        
//        makeRequest(serviceResource: .getIngredients)?.responseObject { (response: DataResponse<IngredientNetworkModel>) in
//            
//            let ingredientResponse = response.result.value
//            print(ingredientResponse)
//        }
        
        return makeRequest(serviceResource: .getIngredients)?.responseJSON().then(execute: { (<#Any#>) -> U in
            <#code#>
        })
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
