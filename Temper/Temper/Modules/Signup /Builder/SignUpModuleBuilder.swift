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
        
        guard let signupOrSignInViewController = container.resolve(SignUpViewable.self) as? UIViewController  else { return nil }
        return Temper.Module(viewController: signupOrSignInViewController)
    }
    
    private func registerView() {
        container.register(SignUpViewable.self, factory: { _ in
            SignupOrSignInViewController.instantiate()
        }).inObjectScope(.container)
    }
}
