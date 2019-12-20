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
    var signUpRouter: SignUpRouter?
    var mapRouter: MapRouter?
    
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
            signUpRouter.delegate = self
            startChildRouter(signUpRouter)
        }
    }
    
    func didTapLoginButton() {
        if let signUpRouter = signUpRouter {
            signUpRouter.delegate = self
            startChildRouter(signUpRouter)
        }
    }
    
    func didTappMapButton(jobs: [Job]) {
        if let mapRouter = mapRouter {
            mapRouter.jobs = jobs
            mapRouter.delegate = self
            startChildRouter(mapRouter)
        }
    }
}

// MARK: - MapRouterDelegate
extension JobsRouter: MapRouterDelegate {
    func mapRouterDidFinish(_ mapRouter: MapRouter) {
        mapRouter.stop()
        removeChildRouter(mapRouter)
    }
}

// MARK: - SignUpRouterDelegate
extension JobsRouter: SignUpRouterDelegate {
    func signupRouterDidFinish(_ signUpRouter: SignUpRouter) {
        signUpRouter.stop()
        removeChildRouter(signUpRouter)
    }
}
