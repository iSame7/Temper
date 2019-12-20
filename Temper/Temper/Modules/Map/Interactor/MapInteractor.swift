//
//  MapInteractor.swift
//  Temper
//
//  Created by Sameh Mabrouk on 20/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

class MapInteractor: MapInteractable {
    private let locationService: LocationServiceChecking
    
    init(locationService: LocationServiceChecking) {
        self.locationService = locationService
    }
    
    func determineUserLocation(completion: @escaping UserLocationBlock) {
        locationService.requestAuthorization()
        locationService.requestUserLocation { location in
            completion(location)
        }
    }
}
