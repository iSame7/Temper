//
//  MapPresenter.swift
//  Temper
//
//  Created by Sameh Mabrouk on 20/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

import CoreLocation

class MapPresenter: MapPresentable {
    // MARK: - Properties
    
    private weak var mapView: MapViewable?
    private let mapInteractor: MapInteractable
    
    var jobs: [Job]
    
    // MARK: - Init
    
    init(mapView: MapViewable, mapInteractor: MapInteractable, jobs: [Job]) {
        self.mapView = mapView
        self.mapInteractor = mapInteractor
        self.jobs = jobs
    }
    
    func viewDidLoad() {
        mapInteractor.determineUserLocation { [weak self] location in
            self?.mapView?.updateUserLocation(MapViewController.LocationViewModel(lat: location.lat, lng: location.lng))
        }
    }
    
    func getJobs() {
        mapView?.update(jobs)
    }
    
    func annotationsForJobs() -> [JobAnnotation] {
        var annotations = [JobAnnotation]()
        jobs.forEach { job in
            if let locationLat = job.location.lat, let locationLng = job.location.lng {
                let jobAnnotation = JobAnnotation(coordinate: CLLocationCoordinate2D(latitude: Double(locationLat)!, longitude: Double(locationLng)!), title: job.jobCategory.description, subtitle: job.client.name)
                annotations.append(jobAnnotation)
            }
        }
        
        return annotations
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfItemsInSection() -> Int {
        return jobs.count
    }
    
    func itemAt(index: Int) -> Job {
        return jobs[index]
    }
    
    func viewModelAtIndex(index: Int) -> JobCollectionViewCell.ViewModel {
        let job = jobs[index]
        return JobCollectionViewCell.ViewModel(imageName: job.client.photos.first?.formats?.first?.cdnUrl, title: job.jobCategory.description, subtitle: job.client.name, description: String(format:"€ %.2f", job.maxPossibleEarningsHour))
    }
}
