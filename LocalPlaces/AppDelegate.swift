//
//  AppDelegate.swift
//  LocalPlaces
//
//  Created by Bruno Rigo Werminghoff on 07/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import UIKit
import Resolver

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    @Injected var appCoordinator: AbstractAppCoordinator 
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if CommandLine.arguments.contains(AppLaunchArguments.noViewAnimations.rawValue) {
            UIView.setAnimationsEnabled(false)
        }
        
        window = UIWindow()
        if CommandLine.arguments.contains(AppLaunchArguments.noLayerAnimations.rawValue) {
            window?.layer.speed = 0
        }
        
        window?.rootViewController = appCoordinator.rootViewController
        window?.makeKeyAndVisible()
        
        return true
    }

}

