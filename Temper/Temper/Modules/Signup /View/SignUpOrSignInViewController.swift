//
//  SignupOrSignInViewController.swift
//  Temper
//
//  Created by Sameh Mabrouk on 20/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

import UIKit

class SignupOrSignInViewController: UIViewController, SignUpViewable {
    
}


// MARK: - StoryboardInstantiatable

extension SignupOrSignInViewController: StoryboardInstantiatable {
    static var instantiateType: StoryboardInstantiateType {
        return .identifier("SignUpOrSignInViewController")
    }
    
    static var storyboardName: String {
        return StoryboardName.jobs.rawValue
    }
}
