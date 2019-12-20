//
//  MapBuilder.swift
//  Temper
//
//  Created by Sameh Mabrouk on 20/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

import Swinject
import Alamofire
import CoreLocation

protocol MapModueBuilderBuildable: ModuleBuildable {
    func buildModule(with jobs: [Job]) -> Temper.Module?
}

class MapModueBuilder: MapModueBuilderBuildable {

    private let container: Container
    
    init(container: Container) {
        self.container = container
        Container.loggingFunction = nil
    }

    func buildModule(with jobs: [Job]) -> Temper.Module? {
        registerView()
        registerLocationService()
        registerInteractor()
        registerPresenter(jobs: jobs)
        
        guard let mapViewController = container.resolve(MapViewable.self) as? UIViewController  else { return nil }
        let navController = UINavigationController(rootViewController: mapViewController)
        return Temper.Module(viewController: navController)
    }
    
    private func registerLocationService() {
        container.register(CLLocationManager.self, factory: { _ in CLLocationManager() }).initCompleted({ _, manager in
            manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            manager.distanceFilter = 5
            manager.allowsBackgroundLocationUpdates = true
            manager.activityType = .fitness
            if #available(iOS 11.0, *) {
                manager.showsBackgroundLocationIndicator = false
            }
        }).inObjectScope(.container)
        
        container.register(LocationServiceChecking.self) { r in
            LocationService(locationManager: r.resolve(CLLocationManager.self)!)
        }
    }
    
    private func registerInteractor() {
        container.register(MapInteractable.self, factory: { r in
            MapInteractor(locationService: r.resolve(LocationServiceChecking.self)!)
        }).inObjectScope(.container)
    }
    
    private func registerPresenter(jobs: [Job]) {
        container.register(MapPresentable.self, factory: { r in
            MapPresenter(mapView: r.resolve(MapViewable.self)!, mapInteractor: r.resolve(MapInteractable.self)!, jobs: jobs)
        }).initCompleted({ (r, presenter) in
            if let presenter = presenter as? MapPresenter {
                presenter.delegate = r.resolve(MapRouter.self)!
            }
        }).inObjectScope(.container)
    }
    
    private func registerView() {
        container.register(MapViewable.self, factory: { _ in
            MapViewController.instantiate()
        }).initCompleted({ (r, view) in
            if let mapViewController = view as? MapViewController {
                mapViewController.presenter = r.resolve(MapPresentable.self)!
            }
        }).inObjectScope(.container)
    }
}
