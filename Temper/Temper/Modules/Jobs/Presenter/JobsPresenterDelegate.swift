//
//  JobsPresenterRouterDelegate.swift
//  Temper
//
//  Created by Sameh Mabrouk on 20/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

protocol JobsPresenterDelegate: class {
    func didTapSignupButton()
    func didTapLoginButton()
    func didTappMapButton(jobs: [Job])
}
