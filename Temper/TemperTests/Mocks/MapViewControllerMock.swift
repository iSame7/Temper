//
//  MapViewControllerMock.swift
//  TemperTests
//
//  Created by Sameh Mabrouk on 21/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

@testable import Temper

import UIKit.UIViewController

class MapViewControllerMock: UIViewController, MapViewable {
    var invokedUpdate = false
    var invokedUpdateCount = 0
    var invokedUpdateParameters: (model: [Job], Void)?
    var invokedUpdateParametersList = [(model: [Job], Void)]()
    func update(_ model: [Job]) {
        invokedUpdate = true
        invokedUpdateCount += 1
        invokedUpdateParameters = (model, ())
        invokedUpdateParametersList.append((model, ()))
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
    var invokedUpdateUserLocation = false
    var invokedUpdateUserLocationCount = 0
    var invokedUpdateUserLocationParameters: (locationViewModel: MapViewController.LocationViewModel, Void)?
    var invokedUpdateUserLocationParametersList = [(locationViewModel: MapViewController.LocationViewModel, Void)]()
    func updateUserLocation(_ locationViewModel: MapViewController.LocationViewModel) {
        invokedUpdateUserLocation = true
        invokedUpdateUserLocationCount += 1
        invokedUpdateUserLocationParameters = (locationViewModel, ())
        invokedUpdateUserLocationParametersList.append((locationViewModel, ()))
    }
}
