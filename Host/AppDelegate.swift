//
//  AppDelegate.swift
//  Host
//
//  Created by Vinay Jain on 16/05/20.
//  Copyright © 2020 Vinay Jain. All rights reserved.
//

import UIKit
import Stocks

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if ProcessInfo.processInfo.environment["XCInjectBundleInto"] != nil {
            return false
        }        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        let navigationController = UINavigationController()
        let rootWireframe = WatchlistWireframe()
        navigationController.setRootWireframe(rootWireframe)
        self.window?.rootViewController = navigationController
        return true
    }
}

