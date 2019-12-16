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
    
    func testGetJobs() {
        // Given
        jobsInteractorMock.stubbedGetJobsCompletionResult = ([Job()], nil)
        
        // When
        sut.getJobs()
        
        // Then
        XCTAssertTrue(jobsViewControllerMock.invokedUpdate)
    }
}

private class JobsViewControllerMock: UIViewController, JobsViewable {
    var invokedUpdate = false
    var invokedUpdateCount = 0
    var invokedUpdateParameters: (jobs: [Job], Void)?
    var invokedUpdateParametersList = [(jobs: [Job], Void)]()
    func update(_ jobs: [Job]) {
        invokedUpdate = true
        invokedUpdateCount += 1
        invokedUpdateParameters = (jobs, ())
        invokedUpdateParametersList.append((jobs, ()))
    }
    var invokedShowError = false
    var invokedShowErrorCount = 0
    var invokedShowErrorParameters: (error: Error, Void)?
    var invokedShowErrorParametersList = [(error: Error, Void)]()
    func showError(error: Error) {
        invokedShowError = true
        invokedShowErrorCount += 1
        invokedShowErrorParameters = (error, ())
        invokedShowErrorParametersList.append((error, ()))
    }
}

private class JobsInteractorMock: JobsInteractable {
    var invokedGetJobs = false
    var invokedGetJobsCount = 0
    var stubbedGetJobsCompletionResult: ([Job]?, Error?)?
    func getJobs(completion: @escaping ([Job]?, Error?) -> Void) {
        invokedGetJobs = true
        invokedGetJobsCount += 1
        if let result = stubbedGetJobsCompletionResult {
            completion(result.0, result.1)
        }
    }
}
