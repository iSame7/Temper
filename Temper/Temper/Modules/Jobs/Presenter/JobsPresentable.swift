//
//  JobsPresentable.swift
//  Temper
//
//  Created by Sameh Mabrouk on 15/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

protocol JobsPresentable: TemperPresentable {
    var jobs: [String: [Job]]? { get }
    
    func getJobs()
    func getMoreJobs()
    
    func numberOfItemsInSection(index: Int) -> Int
    func buildCardContentViewModels() -> [CardContentViewModel]
}

