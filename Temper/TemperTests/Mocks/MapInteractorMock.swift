//
//  JobInteractorMock.swift
//  TemperTests
//
//  Created by Sameh Mabrouk on 21/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

@testable import Temper

class MapInteractorMock: MapInteractable {
    var invokedDetermineUserLocation = false
    var invokedDetermineUserLocationCount = 0
    var stubbedDetermineUserLocationCompletionResult: (UserLocation, Void)?
    func determineUserLocation(completion: @escaping UserLocationBlock) {
        invokedDetermineUserLocation = true
        invokedDetermineUserLocationCount += 1
        if let result = stubbedDetermineUserLocationCompletionResult {
            completion(result.0)
        }
    }
}
