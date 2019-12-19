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
    private var jobDaystoLoad: String {
        var dates = Date().toString()
        if jobsLimit > 1 {
            for day in 1..<jobsLimit {
                guard let newDate =  Date().add(days: day)?.toString() else {
                    continue
                }
                dates += ",\(newDate)"
            }
        }
        
        return dates
    }
    
    var jobs: [String: [Job]]?
    
    // MARK: - Init
    
    init(jobsInteractor: JobsInteractable, jobsView: JobsViewable) {
        self.jobsInteractor = jobsInteractor
        self.jobsView = jobsView
    }
    
    func getJobs() {
        jobsInteractor.getJobsFor(dates: jobDaystoLoad) { [weak self] (jobs, error) in
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
    
    func sectionHeaderAt(index: Int) -> String? {
        guard let jobs = jobs else { return nil }
        
        let formattedStringDate = Array(jobs.keys)[index].toDate()?.toString(format: "EEEE dd MMMM")
        return formattedStringDate
    }
    
    func numberOfItemsInSection(index: Int) -> Int {
        guard let jobs = jobs else { return 0 }
        
        return Array(jobs.values)[index].count
    }
    
    func itemsAt(section: Int) -> [CardContentViewModel]? {
        guard let jobs = jobs else { return nil }
        
        let key = Array(jobs.keys)[section]
        guard let jobsAtSection = jobs[key] else { return nil }
        
        var cardContentViewModels = [CardContentViewModel]()
        jobsAtSection.forEach { job in
            let shifts: String
            if let startTime = job.shifts.first?.startTime, let endTime = job.shifts.first?.endTime {
                shifts = startTime + "-" + endTime
            } else {
                shifts = "No available shift"
                assertionFailure("No shifts available for this job\(job.jobCategory.description)")
            }
            cardContentViewModels.append(CardContentViewModel(primary: job.jobCategory.description, secondary: job.client.name, description: shifts, image: job.client.photos.first?.formats?.first?.cdnUrl ?? ""))
        }
        
        return cardContentViewModels
    }
    
    func itemAtIndex(index: Int, in section: Int) -> CardContentViewModel? {
        return itemsAt(section: section)?[index]
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
