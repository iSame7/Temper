//
//  MapInteractable.swift
//  Temper
//
//  Created by Sameh Mabrouk on 20/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

struct UserLocation: Codable {
    let lat: Double
    let lng: Double
    let address: String?
    let crossStreet: String?
    let distance: Double?
    let postalCode: String?
    let cc: String?
    let city: String?
    let state: String?
    let country: String?
}

typealias UserLocationBlock = (UserLocation) -> Void

protocol MapInteractable {
    func determineUserLocation(completion: @escaping UserLocationBlock)
}
