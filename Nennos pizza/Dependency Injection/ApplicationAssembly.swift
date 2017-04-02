//
//  ApplicationAssembly.swift
//  Nennos pizza
//
//  Created by Bence Pattogato on 28/03/17.
//  Copyright © 2017 bence.pattogato. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

final class ApplicationAssembly: Assembly {
    
    func assemble(container: Container) {
        registerWindow(container: container)
        registerStoryboards(container: container)
        registerViewControllers(container: container)
    }
    
    private func registerStoryboards(container: Container) {
        Storyboards.all().forEach {
            storyboard in
            
            container.register(
                UIStoryboard.self,
                name: storyboard.name,
                factory: { (r) -> UIStoryboard in
                    SwinjectStoryboard.create(
                        name: storyboard.name,
                        bundle: nil,
                        container: container)
            }).inObjectScope(.container)
        }
    }
    
    private func registerWindow(container: Container) {
        container.register(UIWindow.self) { (r) -> UIWindow in
            let window = UIWindow(frame: UIScreen.main.bounds)
            window.makeKeyAndVisible()
            return window
            }.inObjectScope(.container)
    }
    
    private func registerViewControllers(container: Container) {
        
        // Custom pizza viewcontroller
        container.storyboardInitCompleted(CustomPizzaViewController.self) { r, c in
            c.dataProvider = r.resolve(CustomPizzaDataProviderProtocol.self)
        }
        
        // Menu viewcontroller
        container.storyboardInitCompleted(MenuViewController.self) { r, c in
            c.dataProvider = r.resolve(MenuDataProviderProtocol.self)
        }
        
        // Cart viewcontroller
        container.storyboardInitCompleted(CartViewController.self) { r, c in
            c.dataProvider = r.resolve(CartDataProviderProtocol.self)
        }
        
        // Drinks viewcontroller
        container.storyboardInitCompleted(DrinksViewController.self) { r, c in
            c.dataProvider = r.resolve(DrinksDataProviderProtocol.self)
        }
        
        // ThankYou viewcontroller
        container.storyboardInitCompleted(ThankYouViewContoller.self) { r, c in
            c.applicationRouter = r.resolve(ApplicationRouterProtocol.self)
        }
    }
    
}

enum Storyboards {
    case launchScreen
    case menu
    case cart
    case create
    case main
    
    static func all() -> [Storyboards] {
        return [
            launchScreen,
            menu,
            cart,
            create,
            main
        ]
    }
    
    var name: String {
        switch self {
        case .launchScreen: return "LaunchScreen"
        case .menu: return "Menu"
        case .cart: return "Cart"
        case .create: return "Create"
        case .main: return "Main"
        }
    }
}

enum ViewControllers {
    case customPizza
    case menu
    case mainNavigation
    case thankYou
    case cart
    
    var storyboard: Storyboards {
        switch self {
        case .customPizza:
            return .create
        case .menu:
            return .menu
        case .mainNavigation:
            return .main
        case .thankYou, .cart:
            return .cart
        }
    }
    
    var identifier: String {
        switch self {
        case .customPizza: return "CustomPizzaViewController"
        case .menu: return "MenuViewController"
        case .mainNavigation: return "MainNavigationController"
        case .thankYou: return "ThankYouViewController"
        case .cart: return "CartViewController"
        }
    }
}
