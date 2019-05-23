//
//  RootWireFrame.swift
//  MyStocks
//
//  Created by Vinay Jain on 15/05/19.
//  Copyright © 2019 Vinay Jain. All rights reserved.
//

import Foundation
import UIKit

class RootWireframe : NSObject {
    func showRootViewController(viewController: UIViewController, inWindow: UIWindow) {
        let navigationController = navigationControllerFromWindow(window: inWindow)
        navigationController.viewControllers = [viewController]
    }
    
    func navigationControllerFromWindow(window: UIWindow) -> UINavigationController {
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        return navigationController
    }
}
