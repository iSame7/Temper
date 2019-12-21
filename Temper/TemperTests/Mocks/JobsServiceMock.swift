//
//  JobsServiceMock.swift
//  TemperTests
//
//  Created by Sameh Mabrouk on 20/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

@testable import Temper

class JobsServiceMock: JobsFetching {
    var invokedFetchJobsFor = false
    var invokedFetchJobsForCount = 0
    var invokedFetchJobsForParameters: (dates: String, Void)?
    var invokedFetchJobsForParametersList = [(dates: String, Void)]()
    var stubbedFetchJobsForCompletionResult: ([String: [Job]]?, TemperError?)?
    func fetchJobsFor(dates: String, completion: @escaping ([String: [Job]]?, TemperError?) -> Void) {
        invokedFetchJobsFor = true
        invokedFetchJobsForCount += 1
        invokedFetchJobsForParameters = (dates, ())
        invokedFetchJobsForParametersList.append((dates, ()))
        if let result = stubbedFetchJobsForCompletionResult {
            completion(result.0, result.1)
        }
    }
}
