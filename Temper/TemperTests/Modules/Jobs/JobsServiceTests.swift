//
//  JobsServiceTests.swift
//  TemperTests
//
//  Created by Sameh Mabrouk on 20/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

@testable import Temper

import XCTest

class JobsServiceTests: XCTestCase {
    
    // MARK: - Test properties
    
    private let jobsServiceMock = JobsServiceMock()
    private let sessionManagerMock = SessionManagerMock()
    private var sut: JobsService!

    // MARK: - Test life cycle
    
    override func setUp() {
        sut = JobsService(sessionManager: sessionManagerMock, requestRetrier: NetworkRequestRetrier())
    }
    
    override func tearDown() {
        sut = nil
    }
    
    // MARK: - Tests

    func testFetchJobsForDates() {
        // When
        sut.fetchJobsFor(dates: "2019-12-20") { (jobs, error) in
            // Then
            var allJobs = [SectionJob]()
            jobs?.sorted() { $0.key < $1.key }.forEach { (key, value)  in
                allJobs.append(SectionJob(section: key, jobs: value))
            }
            XCTAssertEqual(allJobs.first?.jobs.count, 6)
        }
    }
}
