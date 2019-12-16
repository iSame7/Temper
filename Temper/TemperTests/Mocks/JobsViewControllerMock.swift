//
//  JobsViewControllerMock.swift
//  TemperTests
//
//  Created by Sameh Mabrouk on 16/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

@testable import Temper

import UIKit.UIViewController

class JobsViewControllerMock: UIViewController, JobsViewable {
    var invokedUpdate = false
    var invokedUpdateCount = 0
    var invokedUpdateParameters: (jobs: [Job], Void)?
    var invokedUpdateParametersList = [(jobs: [Job], Void)]()
    func update(_ jobs: [Job]) {
        invokedUpdate = true
        invokedUpdateCount += 1
        invokedUpdateParameters = (jobs, ())
        invokedUpdateParametersList.append((jobs, ()))
    }
    var invokedShowError = false
    var invokedShowErrorCount = 0
    var invokedShowErrorParameters: (error: Error, Void)?
    var invokedShowErrorParametersList = [(error: Error, Void)]()
    func showError(error: Error) {
        invokedShowError = true
        invokedShowErrorCount += 1
        invokedShowErrorParameters = (error, ())
        invokedShowErrorParametersList.append((error, ()))
    }
}
