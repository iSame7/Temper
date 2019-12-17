//
//  JobsService.swift
//  Temper
//
//  Created by Sameh Mabrouk on 15/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

import Alamofire

protocol JobsFetching {
    func fetchJobsFor(dates: String, completion: @escaping ([String: [Job]]?, Error?) -> Void)
}

class JobsService: JobsFetching {
    
    // MARK: - Private properties
    
    let sessionManager: SessionManager
    let requestRetrier: RequestRetrier
    
    // MARK: - Init
    
    init(sessionManager: SessionManager, requestRetrier: RequestRetrier) {
        self.sessionManager = sessionManager
        self.requestRetrier = requestRetrier
    }
    
    // MARK: - JobsFetching
    
    func fetchJobsFor(dates: String, completion: @escaping ([String: [Job]]?, Error?) -> Void) {
        sessionManager.request(Router.fetchJobs(dates: dates)).responseData { response in
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            let content: Result<TemperContent> = JSONDecoder().decodeResponse(from: response)
            
            completion(content.value?.data.periods, content.error)
        }
    }
}
