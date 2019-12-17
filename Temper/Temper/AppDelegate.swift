//
//  AppDelegate.swift
//  Temper
//
//  Created by Sameh Mabrouk on 13/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

import UIKit
import Swinject

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var jobsBuilder: ModuleBuildable!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window =  UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        if let jobsBuilder = Container.shared.resolve(ModuleBuildable.self), let window = self.window {
            window.rootViewController = jobsBuilder.buildModule()?.viewController
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}

