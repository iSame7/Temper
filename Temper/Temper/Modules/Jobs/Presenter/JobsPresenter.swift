//
//  JobsPresenter.swift
//  Temper
//
//  Created by Sameh Mabrouk on 15/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

class JobsPresenter: JobsPresentable {
    
    private let jobsInteractor: JobsInteractable
    private let jobsView: JobsViewable
    
    init(jobsInteractor: JobsInteractable, jobsView: JobsViewable) {
        self.jobsInteractor = jobsInteractor
        self.jobsView = jobsView
    }
    
    func getJobs() {
        jobsInteractor.getJobs {  [weak self] (jobs, error) in
            if let jobs = jobs {
                self?.jobsView.update(jobs)
            } else if let error = error {
                self?.jobsView.showError(error: error)
            }
        }
    }
}
