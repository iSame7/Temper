//
//  JobsInteractable.swift
//  Temper
//
//  Created by Sameh Mabrouk on 15/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

protocol JobsInteractable {
    func getJobsFor(dates: String, completion: @escaping ([SectionJob]?, TemperError?) -> Void)
}
