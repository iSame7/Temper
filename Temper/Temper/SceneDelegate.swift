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
    var appRouter: JobsRouter!
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            window = UIWindow(windowScene: windowScene)
            appRouter = JobsRouter(jobsBuilder: Container.shared.resolve(ModuleBuildable.self))
            appRouter.window = window
            appRouter.start()
        }
    }
}

