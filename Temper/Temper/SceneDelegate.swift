//
//  SceneDelegate.swift
//  Temper
//
//  Created by Sameh Mabrouk on 13/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

import UIKit
import Swinject

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var jobsBuilder: ModuleBuildable!
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {

            let window = UIWindow(windowScene: windowScene)

            if let jobsBuilder = Container.shared.resolve(ModuleBuildable.self) {
                window.rootViewController = jobsBuilder.buildModule()?.viewController
            }

            self.window = window
            window.makeKeyAndVisible()
        }
    }
}

