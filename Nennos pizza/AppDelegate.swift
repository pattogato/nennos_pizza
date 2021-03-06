//
//  AppDelegate.swift
//  Nennos pizza
//
//  Created by Bence Pattogato on 25/03/17.
//  Copyright © 2017 bence.pattogato. All rights reserved.
//

import UIKit
import Swinject
import SwinjectStoryboard

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        BuddyBuildSDK.setup()
        
        // Load application window
        window = DIManager.resolve(service: UIWindow.self)
        DIManager.resolve(service: CartManagerProtocol.self).loadPersistedCart()
        DIManager.resolve(service: ApplicationRouterProtocol.self).start()
        
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        DIManager.resolve(service: CartManagerProtocol.self).persistCart()
    }

}

