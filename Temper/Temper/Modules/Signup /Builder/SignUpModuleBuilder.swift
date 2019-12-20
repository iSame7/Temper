//
//  SignupModuleBuilder.swift
//  Temper
//
//  Created by Sameh Mabrouk on 20/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

import Swinject

class SignUpModuleBuilder: ModuleBuildable {
    private let container: Container
    
    init(container: Container) {
        self.container = container
        Container.loggingFunction = nil
    }
    
    func buildModule() -> Temper.Module? {
        registerView()
        registerPresenter()
        
        guard let signupOrSignInViewController = container.resolve(SignUpViewable.self) as? UIViewController  else { return nil }
        let navController = UINavigationController(rootViewController: signupOrSignInViewController)
        return Temper.Module(viewController: navController)
    }
    
    private func registerView() {
        container.register(SignUpViewable.self, factory: { _ in
            SignupOrSignInViewController.instantiate()
        }).initCompleted({ (r, view) in
            if let signupOrSignInViewController = view as? SignupOrSignInViewController {
                signupOrSignInViewController.presenter = r.resolve(SignUpPresentable.self)!
            }
        }).inObjectScope(.container)
    }
    
    private func registerPresenter() {
        container.register(SignUpPresentable.self, factory: { r in
            SignUpPresenter()
        }).initCompleted({ (r, presenter) in
            if let presenter = presenter as? SignUpPresenter {
                presenter.delegate = r.resolve(SignUpRouter.self)!
            }
        }).inObjectScope(.container)
    }
}
