//
//  MapRouter.swift
//  Temper
//
//  Created by Sameh Mabrouk on 20/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

protocol MapRouterDelegate {
    func mapRouterDidFinish(_ mapRouter: MapRouter)
}

class MapRouter: Router {
    // MARK: - Properties
    
    private let mapModuleBuilder: MapModueBuilderBuildable
    private let rootViewController: Presentable
    var jobs: [Job]?
    var delegate: MapRouterDelegate?
    
    // MARK: - Init
    
    init(mapModuleBuilder: MapModueBuilderBuildable, rootViewController: Presentable) {
        self.mapModuleBuilder = mapModuleBuilder
        self.rootViewController = rootViewController
    }
    
    override func start() {
        if let jobs = jobs, let mapViewController = mapModuleBuilder.buildModule(with: jobs)?.viewController {
            rootViewController.present(mapViewController, animated: true, completion: nil)
        }
    }
    
    override func stop() {
        rootViewController.dismiss(animated: true, completion: nil)
    }
}

// MARK: - MapPresenterDelegate

extension MapRouter: MapPresenterDelegate {
    func didTappCloseButton() {
        delegate?.mapRouterDidFinish(self)
    }
}
