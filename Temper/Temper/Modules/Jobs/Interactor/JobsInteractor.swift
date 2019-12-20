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
    func getJobsFor(dates: String, completion: @escaping ([SectionJob]?, TemperError?) -> Void) {
        jobsService.fetchJobsFor(dates: dates) { (jobs, error) in
            if let error = error {
                completion(nil, error)
            } else {
                var allJobs = [SectionJob]()
                jobs?.sorted() { $0.key < $1.key }.forEach { (key, value)  in
                    allJobs.append(SectionJob(section: key, jobs: value))
                }
                completion(allJobs, error)
            }
        }
    }
}
