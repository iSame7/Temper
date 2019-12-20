//
//  MapViewable.swift
//  Temper
//
//  Created by Sameh Mabrouk on 20/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

protocol MapViewable: class {
    func update(_ model: [Job])
    func showError(error: TemperError)
    func updateUserLocation(_ locationViewModel: MapViewController.LocationViewModel)
}
