//
//  MapInteractorTests.swift
//  TemperTests
//
//  Created by Sameh Mabrouk on 21/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

@testable import Temper

import XCTest

class MapInteractorTests: XCTestCase {
    
    // MARK: - Test properties
    
    private let locationServiceMock = LocationServiceMock()
    private var sut: MapInteractor!

    // MARK: - Test life cycle
    
    override func setUp() {
        sut = MapInteractor(locationService: locationServiceMock)
    }
    
    override func tearDown() {
        sut = nil
    }
    
    // MARK: - Tests

    func testDetermineUserLocationWhenLocationServiceIsEnabled() {
        // Given
        locationServiceMock.isLocationServiceEnabled = true
        
        // When
        sut.determineUserLocation { location in
            // Then
            XCTAssertNotNil(location)
            XCTAssertEqual(location.address, "Nieuwe Doelenstraat 20-22")
            XCTAssertEqual(location.lat, 52.36795609763071)
            XCTAssertEqual(location.lng, 4.895555168247901)
        }
    }
    
    
    func testDetermineUserLocationWhenLocationServiceIsDisabled() {
        // Given
        locationServiceMock.isLocationServiceEnabled = false
        
        // When
        sut.determineUserLocation { location in
            // Then
            XCTAssertEqual(location.lng, 0.0)
            XCTAssertEqual(location.lat, 0.0)
            XCTAssertNil(location.address)
            XCTAssertNil(location.postalCode)
        }
    }
}
