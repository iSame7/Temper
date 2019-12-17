//
//  JobsInteractor.swift
//  Temper
//
//  Created by Sameh Mabrouk on 15/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

class JobsInteractor: JobsInteractable {
    
    // MARK: - Private properties
    
    private let jobsService: JobsFetching
    
    // MARK: - Life cycle
    
    init(jobsService: JobsFetching) {
        self.jobsService = jobsService
    }
    
    // MARK: - JobsInteractable
    
    func getJobs(completion: @escaping ([String: [Job]]?, Error?) -> Void) {
        jobsService.fetchJobsFor(dates: "", completion: completion)
    }
}
