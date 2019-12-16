//
//  JobsService.swift
//  Temper
//
//  Created by Sameh Mabrouk on 15/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

protocol JobsFetching {
    func fetchJobs(completion: @escaping ([Job]?, Error?) -> Void)
}

class JobsService: JobsFetching {
    func fetchJobs(completion: @escaping ([Job]?, Error?) -> Void) {
        completion([Job()], nil)
    }
}
