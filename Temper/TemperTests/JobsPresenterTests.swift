//
//  JobsPresenterTests.swift
//  TemperTests
//
//  Created by Sameh Mabrouk on 14/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

import XCTest
@testable Temper

class JobsPresenterTests: XCTestCase {
    // MARK: - Test properties
    
    let jobsViewControllerMock = JobsViewControllerMock()
    let sut: JobsPresenter!
    
    // MARK: - Test life cycle
    
    override class func setUp() {
        sut = JobsPresenter(view: jobsViewControllerMock)
    }
    
    override func tearDown() {
        sut = nil
    }
    
    // MARK: - Tests
    
    func testLoadJobs() {
        // When
        sut.loadJobs()
        
        // Then
        XCTAssertNotNil(mockMapViewController.jobs)
    }
}

private class JobsViewControllerMock: JobsViewable {
    let presenter: JobsPresentable!
    var jobs: [Jobs]!
}
