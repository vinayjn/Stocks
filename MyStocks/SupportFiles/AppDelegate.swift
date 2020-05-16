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
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        let navigationController = UINavigationController()
        self.window?.rootViewController = navigationController
        return true
    }
}
