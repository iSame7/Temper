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
    private weak var jobsView: JobsViewable?
    
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
    
    private var jobs: [SectionJob]?{
        didSet {
            jobsView?.update()
        }
    }
    
    var delegate: JobsPresenterDelegate?
    
    // MARK: - Init

    init(jobsInteractor: JobsInteractable, jobsView: JobsViewable) {
        self.jobsInteractor = jobsInteractor
        self.jobsView = jobsView
    }
    
    // MARK: - JobsPresentable
    
    func getJobs() {
        jobsInteractor.getJobsFor(dates: jobDaystoLoad) { [weak self] (jobs, error) in
            if let jobs = jobs {
                self?.jobs = jobs
            } else if let error = error {
                self?.jobsView?.showError(error: error)
            }
        }
    }
    
    func getMoreJobs() {
        jobsLimit += 3
        
        getJobs()
    }
    
    func refreshJobs() {
        jobsLimit = 0
        
        getJobs()
    }

    func numberOfSections() -> Int {
        guard let jobs = jobs else { return 0 }
        
        return jobs.count
    }
    
    func numberOfItemsInSection(index: Int) -> Int {
        guard let jobs = jobs else { return 0 }
        
        return jobs[index].jobs.count
    }
        
    func sectionHeaderAt(index: Int) -> String? {
        guard let jobs = jobs else { return nil }
        let formattedStringDate = jobs[index].section.toDate()?.toString(format: "EEEE dd MMMM")
        return formattedStringDate
    }
    
    func itemsAt(section: Int) -> [CardContentViewModel]? {
        guard let jobs = jobs else { return nil }
        
        let jobsAtSection = jobs[section].jobs
        
        var cardContentViewModels = [CardContentViewModel]()
        jobsAtSection.forEach { job in
            let shifts: String
            if let startTime = job.shifts.first?.startTime, let endTime = job.shifts.first?.endTime {
                shifts = startTime + "-" + endTime
            } else {
                shifts = "No available shift"
                assertionFailure("No shifts available for this job\(job.jobCategory.description)")
            }
            cardContentViewModels.append(CardContentViewModel(primary: job.jobCategory.description, secondary: job.client.name, description: shifts, details: String(format:"€ %.2f", job.maxPossibleEarningsHour), image: job.client.photos.first?.formats?.first?.cdnUrl ?? ""))
        }
        
        return cardContentViewModels
    }
    
    func itemAtIndex(index: Int, in section: Int) -> CardContentViewModel? {
        return itemsAt(section: section)?[index]
    }
    
    func didTapSignupButton() {
        delegate?.didTapSignupButton()
    }
    
    func didTapLoginButton() {
        delegate?.didTapLoginButton()
    }
    
    func didTappMapButton() {
        delegate?.didTappMapButton(jobs: combineAllJobs())
    }
}

// MARK: - Helpers

private extension JobsPresenter {
    private func combineAllJobs() -> [Job] {
        var jobs = [Job]()
        self.jobs?.forEach({ sectionJob in
            sectionJob.jobs.forEach { job in
                jobs.append(job)
            }
        })
        
        return jobs
    }
}
