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
    let rootWireFrame = RootWireframe()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.makeKeyAndVisible()
        rootWireFrame.showRootViewController(viewController: SearchViewController(), inWindow: window!)
        return true
    }
}
