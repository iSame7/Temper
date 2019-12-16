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
        jobsInteractorMock.stubbedGetJobsCompletionResult = ([Job()], nil)
        
        // When
        sut.getJobs()
        
        // Then
        XCTAssertTrue(jobsViewControllerMock.invokedUpdate)
    }
    
    func testGetJobsAndInvokeErrorWhenNoJobArrives() {
        // Given
        jobsInteractorMock.stubbedGetJobsCompletionResult = (nil, NSError(domain:"", code: 400, userInfo:nil))
        
        // When
        sut.getJobs()
        
        // Then
        XCTAssertNotNil(jobsViewControllerMock.invokedShowError)
    }
}
