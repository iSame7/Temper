//
//  MapPresenterTests.swift
//  TemperTests
//
//  Created by Sameh Mabrouk on 21/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

@testable import Temper

import XCTest

class MapPresenterTests: XCTestCase {

    // MARK: - Test properties
    
    private let mapViewControllerMock = MapViewControllerMock()
    private let mapPresenterDelegateSpy = MapPresenterDelegateSpy()
    private let mapInteractorMock = MapInteractorMock()
    private let jobsMock = [Job(title: "Vlammers voor achter de bar", location: Location(lat: "52.363728", lng: "4.867635"), maxPossibleEarningsHour: 15.5, jobCategory: JobCategory(description: "Bartending"), shifts: [Shift(startTime: "21:00", endTime: "04:30")], client: Client(name: "LAB111", id: "px79zx", photos: [Photo(formats: [PhotoFormat(cdnUrl: "https://tmpr-photos.ams3.digitaloceanspaces.com/hero/157091.jpg")])])), Job(title: "Vlammers voor achter de bar", location: Location(lat: "52.363728", lng: "4.867635"), maxPossibleEarningsHour: 15.5, jobCategory: JobCategory(description: "Bartending"), shifts: [Shift(startTime: "21:00", endTime: "04:30")], client: Client(name: "LAB111", id: "px79zx", photos: [Photo(formats: [PhotoFormat(cdnUrl: "https://tmpr-photos.ams3.digitaloceanspaces.com/hero/157091.jpg")])]))]
    private var sut: MapPresenter!
    
    // MARK: - Test life cycle
    
    override func setUp() {
        sut = MapPresenter(mapView: mapViewControllerMock, mapInteractor: mapInteractorMock, jobs: jobsMock)
    }
    
    override func tearDown() {
        sut = nil
    }
    
    // MARK: - Tests
    
    func testGetJobsInvokeUpdateWhenNewJobArrives() {
        // When
        sut.getJobs()
        
        // Then
        XCTAssertTrue(mapViewControllerMock.invokedUpdate)
    }

    func testAnnotationsForJobs() {
        // When
        let annotations = sut.annotationsForJobs()
        
        // Then
        XCTAssertEqual(annotations.count, 2)
    }
    
    func testNumberOfSctions() {
        // When
        let numberOfSections = sut.numberOfSections()
        
        // Then
        XCTAssertEqual(numberOfSections, 1)
    }
    
    func testNumberOfItemsInSection() {
        // When
        let numberOfItemsInSection = sut.numberOfItemsInSection()
        
        // Then
        XCTAssertEqual(numberOfItemsInSection, 2)
    }
    
    func testItemAtIndex() {
        // When
        let job = sut.itemAt(index: 0)
        
        // Then
        XCTAssertEqual(job.client.name, "LAB111")
    }
    
    func testViewModelAtIndex() {
        // When
        let viewModel = sut.viewModelAtIndex(index: 0)
        
        // Then
        XCTAssertEqual(viewModel.title, "Bartending")
    }
    
    func testCloseButtonTapped() {
        // Given
        sut.delegate = mapPresenterDelegateSpy
        
        // When
        sut.closeButtonTapped()
        
        // Then
        XCTAssertTrue(mapPresenterDelegateSpy.invokedDidTappCloseButton)
    }
}

