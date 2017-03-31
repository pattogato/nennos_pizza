//
//  AsyncLoadingDataProviderProtocol.swift
//  Nennos pizza
//
//  Created by Bence Pattogato on 31/03/17.
//  Copyright © 2017 bence.pattogato. All rights reserved.
//

import Foundation
import PromiseKit

enum DataProviderError: Swift.Error {
    case dataNotLoadedError
    case indexOutOfBounds
}

protocol AsyncLoadingDataProviderProtocol {
    func loadDataIfNeeded() -> Promise<Void>
    func reloadData() -> Promise<Void>
}
