//
//  JobsRouter.swift
//  Temper
//
//  Created by Sameh Mabrouk on 18/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

import UIKit

class JobsRouter: Router {    
    // MARK: - Properties
    
    private let jobsBuilder: ModuleBuildable?
    var signUpRouter: Router?
    
    var window: UIWindow?
    
    // MARK: - Coordinator
    
    init(jobsBuilder: ModuleBuildable?) {
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

extension JobsRouter: JobsPresenterDelegate  {
    func didTapSignupButton() {
        if let signUpRouter = signUpRouter {
            startChildRouter(signUpRouter)
        }
    }
    
    func didTapLoginButton() {
        if let signUpRouter = signUpRouter {
            startChildRouter(signUpRouter)
        }
    }
}
