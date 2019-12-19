//
//  JobsPresentable.swift
//  Temper
//
//  Created by Sameh Mabrouk on 15/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

protocol JobsPresentable: TemperPresentable {
    var jobs: [SectionJob]? { get }
    
    func getJobs()
    func getMoreJobs()
    func refreshJobs()
    
    func numberOfSections() -> Int
    func numberOfItemsInSection(index: Int) -> Int
    func sectionHeaderAt(index: Int) -> String?
    func itemsAt(section: Int) -> [CardContentViewModel]?
    func itemAtIndex(index: Int, in section: Int) -> CardContentViewModel?
}

