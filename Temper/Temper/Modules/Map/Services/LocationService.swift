//
//  LocationService.swift
//  Temper
//
//  Created by Sameh Mabrouk on 20/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit
import MapKit

protocol LocationServiceChecking {
    func requestAuthorization()
    func requestUserLocation(completion: @escaping UserLocationBlock)
}

class LocationService: NSObject, LocationServiceChecking {
    private let locationManager: CLLocationManager!
    private var status: CLAuthorizationStatus!
    private var locationUpdateCompletion: UserLocationBlock!
    
    required init(locationManager: CLLocationManager) {
        self.locationManager = locationManager
        super.init()
        locationManager.delegate = self
    }
}

extension LocationService {
    func requestAuthorization() {
        if CLLocationManager.locationServicesEnabled() {
            print("location services available")
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
                status = CLAuthorizationStatus.notDetermined
            case .denied:
                status = CLAuthorizationStatus.denied
                //opens phone Settings so user can authorize permission
                guard let validSettingsURL: URL = URL(string: UIApplication.openSettingsURLString) else { return }
                UIApplication.shared.open(validSettingsURL, options: [:], completionHandler: nil)
            case .authorizedWhenInUse:
                status = CLAuthorizationStatus.authorizedWhenInUse
            case .authorizedAlways:
                status = CLAuthorizationStatus.authorizedAlways
            case .restricted:
                status = CLAuthorizationStatus.restricted
                guard let validSettingsURL: URL = URL(string: UIApplication.openSettingsURLString) else { return }
                UIApplication.shared.open(validSettingsURL, options: [:], completionHandler: nil)
            @unknown default:
                assertionFailure("Uknown authorizationStatus")
            }
        }
        else {
            print("location services NOT available")
        }
    }
    
    func requestUserLocation( completion: @escaping UserLocationBlock) {
        locationUpdateCompletion = completion
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
}

//MARK: CLLocationManager Delegate
extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        locationUpdateCompletion(UserLocation(lat: location.coordinate.latitude, lng: location.coordinate.longitude, address: nil, crossStreet: nil, distance: nil, postalCode: nil, cc: nil, city: nil, state: nil, country: nil))
        locationManager.delegate = nil
    }
}
