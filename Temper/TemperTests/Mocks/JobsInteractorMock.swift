//
//  JobsInteractorMock.swift
//  TemperTests
//
//  Created by Sameh Mabrouk on 16/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

@testable import Temper

class JobsInteractorMock: JobsInteractable {
    var invokedGetJobsFor = false
    var invokedGetJobsForCount = 0
    var invokedGetJobsForParameters: (dates: String, Void)?
    var invokedGetJobsForParametersList = [(dates: String, Void)]()
    var stubbedGetJobsForCompletionResult: ([SectionJob]?, TemperError?)?
    func getJobsFor(dates: String, completion: @escaping ([SectionJob]?, TemperError?) -> Void) {
        invokedGetJobsFor = true
        invokedGetJobsForCount += 1
        invokedGetJobsForParameters = (dates, ())
        invokedGetJobsForParametersList.append((dates, ()))
        if let result = stubbedGetJobsForCompletionResult {
            completion(result.0, result.1)
        }
    }
}
