//
//  JobsPresenter.swift
//  Temper
//
//  Created by Sameh Mabrouk on 15/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

import Foundation
import UIKit

class JobsPresenter: JobsPresentable {
    // MARK: - Properties
    
    private let jobsInteractor: JobsInteractable
    private let jobsView: JobsViewable
    private var jobsLimit = 0
    
    var jobs: [String: [Job]]?
    
    // MARK: - Init
    
    init(jobsInteractor: JobsInteractable, jobsView: JobsViewable) {
        self.jobsInteractor = jobsInteractor
        self.jobsView = jobsView
    }
    
    func getJobs() {
        guard let dates =  Date().add(days: jobsLimit)?.toString() else {
            return
        }
        
        jobsInteractor.getJobsFor(dates: dates) { [weak self] (jobs, error) in
            if let jobs = jobs {
                self?.jobs = jobs
                self?.jobsView.update(jobs)
            } else if let error = error {
                self?.jobsView.showError(error: error)
            }
        }
    }
    
    func getMoreJobs() {
        jobsLimit += 3
        
        getJobs()
    }
    
    func numberOfItemsInSection(index: Int) -> Int {
        guard let jobs = jobs else { return 0 }
        
        return Array(jobs.values)[index].count
    }
    
    func buildCardContentViewModels() -> [CardContentViewModel] {
        var cardContentViewModels = [CardContentViewModel]()
        jobs?.values.flatMap({$0}).forEach({ job in
            let shifts: String
            if let startTime = job.shifts.first?.startTime, let endTime = job.shifts.first?.endTime {
                shifts = startTime + "-" + endTime
            } else {
                shifts = "No available shift"
                assertionFailure("No shifts available for this job\(job.jobCategory.description)")
            }
            cardContentViewModels.append(CardContentViewModel(primary: job.jobCategory.description, secondary: job.client.name, description: shifts, image: job.client.photos.first?.formats?.first?.cdnUrl ?? ""))
        })
        
        return cardContentViewModels
    }
}
