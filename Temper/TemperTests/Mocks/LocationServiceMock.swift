//
//  MockLocationService.swift
//  TemperTests
//
//  Created by Sameh Mabrouk on 21/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

@testable import Temper

class LocationServiceMock: LocationServiceChecking {
    var isLocationServiceEnabled = false
    enum Auth {
        case authorized
        case denied
    }
    
    var auth: Auth!
    
    func requestAuthorization() {
        if isLocationServiceEnabled {
            auth = .authorized
        } else {
            auth = .denied
        }
    }
    
    func requestUserLocation(completion: @escaping UserLocationBlock) {
        switch auth {
        case .authorized?:
            completion(UserLocation(lat: 52.36795609763071, lng: 4.895555168247901, address: "Nieuwe Doelenstraat 20-22", crossStreet: nil, distance: nil, postalCode: "1012 CP", cc: nil, city: "Amsterdam", state: "North Holland", country: "Netherlands"))
        default:
            completion(UserLocation(lat: 0.0, lng: 0.0, address: nil, crossStreet: nil, distance: nil, postalCode: nil, cc: nil, city: nil, state: nil, country: nil))
            break
        }
    }
}


