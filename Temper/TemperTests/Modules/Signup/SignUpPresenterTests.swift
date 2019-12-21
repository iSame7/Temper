//
//  SignUpPresenter.swift
//  TemperTests
//
//  Created by Sameh Mabrouk on 21/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

@testable import Temper

import XCTest

class SignUpPresenterTests: XCTestCase {

    // MARK: - Test properties

    private let signUpPresenterDelegateSpy = SignUpPresenterDelegateSpy()
    private var sut: SignUpPresenter!
    
    // MARK: - Test life cycle
    
    override func setUp() {
        sut = SignUpPresenter()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    // MARK: - Tests
  
    func testCloseButtonTapped() {
        // Given
        sut.delegate = signUpPresenterDelegateSpy
        
        // When
        sut.closeButtonTapped()
        
        // Then
        XCTAssertTrue(signUpPresenterDelegateSpy.invokedDidTappCloseButton)
    }
}

