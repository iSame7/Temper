//
//  SignupRouter.swift
//  Temper
//
//  Created by Sameh Mabrouk on 20/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

class SignUpRouter: Router {
    // MARK: - Properties
    
    private let signupModuleBuilder: ModuleBuildable
    private let rootViewController: Presentable
    
    // MARK: - Init
    
    init(signupModuleBuilder: ModuleBuildable, rootViewController: Presentable) {
        self.signupModuleBuilder = signupModuleBuilder
        self.rootViewController = rootViewController
    }
    
    override func start() {
        if let signUpOrSignInViewController = signupModuleBuilder.buildModule()?.viewController {
            rootViewController.present(signUpOrSignInViewController, animated: true, completion: nil)
        }
    }
}
