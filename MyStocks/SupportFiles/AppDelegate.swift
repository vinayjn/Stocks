//
//  AppDelegate.swift
//  MyStocks
//
//  Created by Vinay Jain on 15/05/19.
//  Copyright © 2019 Vinay Jain. All rights reserved.
//

import UIKit

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
