//
//  MapPresentable.swift
//  Temper
//
//  Created by Sameh Mabrouk on 20/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

protocol MapPresentable: class {    
    func viewDidLoad()
    
    func getJobs()
    
    func numberOfSections() -> Int
    func numberOfItemsInSection() -> Int
    func annotationsForJobs() -> [JobAnnotation]
    func itemAt(index: Int) -> Job
    func viewModelAtIndex(index: Int) -> JobCollectionViewCell.ViewModel
}
