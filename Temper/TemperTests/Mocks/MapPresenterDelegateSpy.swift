//
//  MapPresenterDelegateSpy.swift
//  TemperTests
//
//  Created by Sameh Mabrouk on 21/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

@testable import Temper

class MapPresenterDelegateSpy: MapPresenterDelegate {
    var invokedDidTappCloseButton = false
    var invokedDidTappCloseButtonCount = 0
    func didTappCloseButton() {
        invokedDidTappCloseButton = true
        invokedDidTappCloseButtonCount += 1
    }
}
