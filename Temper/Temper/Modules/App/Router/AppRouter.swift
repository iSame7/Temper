//
//  AppRouter.swift
//  Temper
//
//  Created by Sameh Mabrouk on 18/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

import UIKit

class AppRouter: Router {
    
    // MARK: - Properties
    
    private let window: UIWindow?
    private let jobsBuilder: ModuleBuildable?

    lazy var rootViewController: UINavigationController = {
        return UINavigationController(rootViewController: UIViewController())
    }()
    
    // MARK: - Coordinator
    
    init(window: UIWindow?, jobsBuilder: ModuleBuildable?) {
        self.window = window
        self.jobsBuilder = jobsBuilder
    }
    
    override func start() {
        guard let window = window else {
            return
        }
        
        if let jobsBuilder = jobsBuilder {
            window.rootViewController = jobsBuilder.buildModule()?.viewController
            window.makeKeyAndVisible()
        }
    }
}
