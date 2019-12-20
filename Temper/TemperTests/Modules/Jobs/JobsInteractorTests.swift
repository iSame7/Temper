//
//  JobsInteractorTests.swift
//  TemperTests
//
//  Created by Sameh Mabrouk on 20/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

@testable import Temper

import XCTest

class JobsInteractorTests: XCTestCase {
    
    // MARK: - Test properties
    
    private let jobsServiceMock = JobsServiceMock()
    private var sut: JobsInteractor!
    private let jobsMock = ["2019-12-20": [Job(title: "Vlammers voor achter de bar", location: Location(lat: "52.363728", lng: "4.867635"), maxPossibleEarningsHour: 15.5, jobCategory: JobCategory(description: "Bartending"), shifts: [Shift(startTime: "21:00", endTime: "04:30")], client: Client(name: "LAB111", id: "px79zx", photos: [Photo(formats: [PhotoFormat(cdnUrl: "https://tmpr-photos.ams3.digitaloceanspaces.com/hero/157091.jpg")])])), Job(title: "Vlammers voor achter de bar", location: Location(lat: "52.363728", lng: "4.867635"), maxPossibleEarningsHour: 15.5, jobCategory: JobCategory(description: "Bartending"), shifts: [Shift(startTime: "21:00", endTime: "04:30")], client: Client(name: "LAB111", id: "px79zx", photos: [Photo(formats: [PhotoFormat(cdnUrl: "https://tmpr-photos.ams3.digitaloceanspaces.com/hero/157091.jpg")])]))]]

    // MARK: - Test life cycle
    
    override func setUp() {
        sut = JobsInteractor(jobsService: jobsServiceMock)
    }
    
    override func tearDown() {
        sut = nil
    }
    
    // MARK: - Tests

    func testGetJobsForDatesWhenThereAreJobsAvailable() {
        // Given
        jobsServiceMock.stubbedFetchJobsForCompletionResult = (jobsMock, nil)
        
        // When
        sut.getJobsFor(dates: "2019-12-20") { (jobs, error) in
            // Then
            XCTAssertEqual(jobs?.count, 1)
        }
    }
    
    func testGetJobsForDatesWhenThereAreNoJobsAvailable() {
        // Given
        jobsServiceMock.stubbedFetchJobsForCompletionResult = (nil, nil)
        
        // When
        sut.getJobsFor(dates: "2019-12-20") { (jobs, error) in
            // Then
            XCTAssertEqual(jobs?.count, 0)
        }
    }
    
    func testGetJobsForDatesWhenThereIsAnError() {
        // Given
        jobsServiceMock.stubbedFetchJobsForCompletionResult = (nil, TemperError.noResponse)
        
        // When
        sut.getJobsFor(dates: "2019-12-20") { (jobs, error) in
            // Then
            XCTAssertEqual(error, TemperError.noResponse)
        }
    }
}
