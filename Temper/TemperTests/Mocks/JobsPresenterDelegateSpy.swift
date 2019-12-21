//
//  JobsPresenterDelegateSpy.swift
//  TemperTests
//
//  Created by Sameh Mabrouk on 20/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

@testable import Temper

class JobsPresenterDelegateSpy: JobsPresenterDelegate {
    var invokedDidTapSignupButton = false
    var invokedDidTapSignupButtonCount = 0
    func didTapSignupButton() {
        invokedDidTapSignupButton = true
        invokedDidTapSignupButtonCount += 1
    }
    var invokedDidTapLoginButton = false
    var invokedDidTapLoginButtonCount = 0
    func didTapLoginButton() {
        invokedDidTapLoginButton = true
        invokedDidTapLoginButtonCount += 1
    }
    var invokedDidTappMapButton = false
    var invokedDidTappMapButtonCount = 0
    var invokedDidTappMapButtonParameters: (jobs: [Job], Void)?
    var invokedDidTappMapButtonParametersList = [(jobs: [Job], Void)]()
    func didTappMapButton(jobs: [Job]) {
        invokedDidTappMapButton = true
        invokedDidTappMapButtonCount += 1
        invokedDidTappMapButtonParameters = (jobs, ())
        invokedDidTappMapButtonParametersList.append((jobs, ()))
    }
}
