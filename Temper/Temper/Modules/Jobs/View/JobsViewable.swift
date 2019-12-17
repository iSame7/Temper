//
//  JobsViewable.swift
//  Temper
//
//  Created by Sameh Mabrouk on 16/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

protocol JobsViewable {
    func update(_ jobs: [String: [Job]])
    func showError(error: Error)
}
