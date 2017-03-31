//
//  CartManager.swift
//  Nennos pizza
//
//  Created by Bence Pattogato on 31/03/17.
//  Copyright © 2017 bence.pattogato. All rights reserved.
//

import Foundation

protocol ShoppableItem {
    var name: String { get }
    var price: Double { get }
    var associatedObject: AnyObject { get set }
}

protocol CartManagerProtocol {
    func addItemToCart(item: ShoppableItem)
}
