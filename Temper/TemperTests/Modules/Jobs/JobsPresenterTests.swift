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
    private let jobsPresenterDelegateSpy = JobsPresenterDelegateSpy()
    private let jobsInteractorMock = JobsInteractorMock()
    private let sectionJobMock = [SectionJob(section: "2019-12-20", jobs: [Job(title: "Vlammers voor achter de bar", location: Location(lat: "52.363728", lng: "4.867635"), maxPossibleEarningsHour: 15.5, jobCategory: JobCategory(description: "Bartending"), shifts: [Shift(startTime: "21:00", endTime: "04:30")], client: Client(name: "LAB111", id: "px79zx", photos: [Photo(formats: [PhotoFormat(cdnUrl: "https://tmpr-photos.ams3.digitaloceanspaces.com/hero/157091.jpg")])])), Job(title: "Vlammers voor achter de bar", location: Location(lat: "52.363728", lng: "4.867635"), maxPossibleEarningsHour: 15.5, jobCategory: JobCategory(description: "Bartending"), shifts: [Shift(startTime: "21:00", endTime: "04:30")], client: Client(name: "LAB111", id: "px79zx", photos: [Photo(formats: [PhotoFormat(cdnUrl: "https://tmpr-photos.ams3.digitaloceanspaces.com/hero/157091.jpg")])]))])]
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
        jobsInteractorMock.stubbedGetJobsForCompletionResult = (sectionJobMock, nil)
        
        // When
        sut.getJobs()
        
        // Then
        XCTAssertTrue(jobsViewControllerMock.invokedUpdate)
    }
    
    func testGetJobsAndInvokeErrorWhenNoJobArrives() {
        // Given
        jobsInteractorMock.stubbedGetJobsForCompletionResult = (nil, TemperError.JSONParsing)
        
        // When
        sut.getJobs()
        
        // Then
        XCTAssertNotNil(jobsViewControllerMock.invokedShowError)
    }
    
    func testGetMoreJobs() {
        // Given
        jobsInteractorMock.stubbedGetJobsForCompletionResult = (sectionJobMock, nil)

        // When
        sut.getMoreJobs()
        
        // Then
        XCTAssertEqual((jobsInteractorMock.invokedGetJobsForParameters?.0)?.filter { $0 == ","}.count, 2)
    }
    
    func testRefreshJobs() {
        // When
        sut.refreshJobs()
        
        // Then
        XCTAssertEqual((jobsInteractorMock.invokedGetJobsForParameters?.0)?.filter { $0 == ","}.count, 0)
    }
    
    func testNumberOfSctions() {
        // Given
        jobsInteractorMock.stubbedGetJobsForCompletionResult = (sectionJobMock, nil)
        sut.getJobs()
        
        // When
        let numberOfSections = sut.numberOfSections()
        
        // Then
        XCTAssertEqual(numberOfSections, 1)
    }
    
    func testNumberOfItemsInSection() {
        // Given
        jobsInteractorMock.stubbedGetJobsForCompletionResult = (sectionJobMock, nil)
        sut.getJobs()
        
        // When
        let numberOfItemsInSection = sut.numberOfItemsInSection(index: 0)
        
        // Then
        XCTAssertEqual(numberOfItemsInSection, 2)
    }
    
    func testSectionHeaderAt() {
        // Given
        jobsInteractorMock.stubbedGetJobsForCompletionResult = (sectionJobMock, nil)
        sut.getJobs()
        
        // When
        let sectionHeader = sut.sectionHeaderAt(index: 0)
        
        // Then
        XCTAssertEqual(sectionHeader, "Friday 20 December")
    }
    
    func testItemsAtSection() {
        // Given
        jobsInteractorMock.stubbedGetJobsForCompletionResult = (sectionJobMock, nil)
        sut.getJobs()
        
        // When
        let itemsAtSection = sut.itemsAt(section: 0)
        
        // Then
        XCTAssertEqual(itemsAtSection?.count, 2)
    }
    
    func testItemAtIndex() {
        // Given
        jobsInteractorMock.stubbedGetJobsForCompletionResult = (sectionJobMock, nil)
        sut.getJobs()
        
        // When
        let item = sut.itemAtIndex(index: 0, in: 0)
        
        // Then
        XCTAssertEqual(item?.primary, "Bartending")
    }
    
    func testDidTapSignupButton() {
        // Given
        sut.delegate = jobsPresenterDelegateSpy
        
        // When
        sut.didTapSignupButton()
        
        // Then
        XCTAssertTrue(jobsPresenterDelegateSpy.invokedDidTapSignupButton)
    }
    
    func testDidTapLoginButton() {
        // Given
        sut.delegate = jobsPresenterDelegateSpy
        
        // When
        sut.didTapLoginButton()
        
        // Then
        XCTAssertTrue(jobsPresenterDelegateSpy.invokedDidTapLoginButton)
    }
    
    func testDidTapMapButton() {
        // Given
        sut.delegate = jobsPresenterDelegateSpy
        
        // When
        sut.didTappMapButton()
        
        // Then
        XCTAssertTrue(jobsPresenterDelegateSpy.invokedDidTappMapButton)
    }
}

