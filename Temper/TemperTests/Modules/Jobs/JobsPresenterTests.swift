//
//  JobsPresenterTests.swift
//  TemperTests
//
//  Created by Sameh Mabrouk on 14/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

@testable import Temper

import XCTest

class JobsPresenterTests: XCTestCase {
    
    // MARK: - Test properties
    
    private let jobsViewControllerMock = JobsViewControllerMock()
    private let jobsInteractorMock = JobsInteractorMock()
    private var sut: JobsPresenter!
    
    // MARK: - Test life cycle
    
    override func setUp() {
        sut = JobsPresenter(jobsInteractor: jobsInteractorMock, jobsView: jobsViewControllerMock)
    }
    
    override func tearDown() {
        sut = nil
    }
    
    // MARK: - Tests
    
    func testGetJobsAndInvokeUpdateWhenNewJobArrives() {
        // Given
        jobsInteractorMock.stubbedGetJobsCompletionResult = ([SectionJob(section: "2019-12-20", jobs: [Job(title: "Vlammers voor achter de bar", location: Location(lat: "52.363728", lng: "4.867635"), maxPossibleEarningsHour: 15.5, jobCategory: JobCategory(description: "Bartending"), shifts: [Shift(startTime: "21:00", endTime: "04:30")], client: Client(name: "LAB111", id: "px79zx", photos: [Photo(formats: [PhotoFormat(cdnUrl: "https://tmpr-photos.ams3.digitaloceanspaces.com/hero/157091.jpg")])]))])], nil)
        
        // When
        sut.getJobs()
        
        // Then
        XCTAssertTrue(jobsViewControllerMock.invokedUpdate)
    }
    
    func testGetJobsAndInvokeErrorWhenNoJobArrives() {
        // Given
        jobsInteractorMock.stubbedGetJobsCompletionResult = (nil, TemperError.JSONParsing)
        
        // When
        sut.getJobs()
        
        // Then
        XCTAssertNotNil(jobsViewControllerMock.invokedShowError)
    }
}
