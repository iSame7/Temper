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
    var invokedUpdateParametersList = [(jobs: [Job], Void)]()
    func update() {
        invokedUpdate = true
        invokedUpdateCount += 1
    }
    var invokedShowError = false
    var invokedShowErrorCount = 0
    var invokedShowErrorParameters: (error: TemperError, Void)?
    var invokedShowErrorParametersList = [(error: TemperError, Void)]()
    func showError(error: TemperError) {
        invokedShowError = true
        invokedShowErrorCount += 1
        invokedShowErrorParameters = (error, ())
        invokedShowErrorParametersList.append((error, ()))
    }
}
