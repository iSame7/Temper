//
//  JobsModuleBuilder.swift
//  Temper
//
//  Created by Sameh Mabrouk on 17/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

import Swinject
import Alamofire

class JobsModuleBuidler: ModuleBuildable {
    
    private let container: Container

    init(container: Container) {
        self.container = container
        Container.loggingFunction = nil
    }
    
    func buildModule() -> Temper.Module? {
        registerView()
        registerJobsService()
        registerInteractor()
        registerPresenter()
        registerNetwork()
        
        guard let jobsViewController = container.resolve(JobsViewable.self) as? UIViewController  else { return nil }
        let navController = UINavigationController(rootViewController: jobsViewController)
        return Temper.Module(viewController: navController)
    }
    
    private func registerInteractor() {
        container.register(JobsInteractable.self, factory: { r in
            JobsInteractor(jobsService: r.resolve(JobsFetching.self)!)
        }).inObjectScope(.container)
    }
    
    private func registerPresenter() {
        container.register(JobsPresentable.self, factory: { r in
            JobsPresenter(jobsInteractor: r.resolve(JobsInteractable.self)!, jobsView: r.resolve(JobsViewable.self)!)
        }).inObjectScope(.container)
    }
    
    func registerNetwork() {
        container.register(SessionManager.self, factory: { r in
            SessionManager()
        }).inObjectScope(.container)
        
        container.register(RequestRetrier.self, factory: { r in
            NetworkRequestRetrier()
        }).inObjectScope(.container)
    }
    
    private func registerJobsService() {
        container.register(JobsFetching.self, factory: { r in
            JobsService(sessionManager: r.resolve(SessionManager.self)!, requestRetrier: r.resolve(RequestRetrier.self)!)
        }).inObjectScope(.container)
    }
    
    private func registerView() {
        container.register(JobsViewable.self, factory: { _ in
            JobsViewController()
        }).initCompleted({ (r, view) in
            if let mapViewController = view as? JobsViewController {
                mapViewController.presenter = r.resolve(JobsPresentable.self)!
            }
        }).inObjectScope(.container)
    }
    
}
