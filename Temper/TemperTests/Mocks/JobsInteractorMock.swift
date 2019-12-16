//
//  JobsInteractorMock.swift
//  TemperTests
//
//  Created by Sameh Mabrouk on 16/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

@testable import Temper

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
