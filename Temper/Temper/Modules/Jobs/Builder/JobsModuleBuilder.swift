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
        registerRouter()
        registerPresenter()
        registerNetwork()
        registerSignUpRouter()
        
        guard let jobsViewController = container.resolve(JobsViewable.self) as? UIViewController  else { return nil }
        return Temper.Module(viewController: jobsViewController)
    }
    
    private func registerInteractor() {
        container.register(JobsInteractable.self, factory: { r in
            JobsInteractor(jobsService: r.resolve(JobsFetching.self)!)
        }).inObjectScope(.container)
    }
    
    func registerRouter() {
        container.register(JobsRouter.self, factory: { r in
            JobsRouter(jobsBuilder: r.resolve(ModuleBuildable.self)!)
        }).initCompleted({ (r, router) in
            router.signUpRouter = r.resolve(SignUpRouter.self)!
        }).inObjectScope(.container)
    }
    
    private func registerPresenter() {
        container.register(JobsPresentable.self, factory: { r in
            JobsPresenter(jobsInteractor: r.resolve(JobsInteractable.self)!, jobsView: r.resolve(JobsViewable.self)!)
        }).initCompleted({ (r, presenter) in
            if let presenter = presenter as? JobsPresenter {
                presenter.delegate = r.resolve(JobsRouter.self)!
            }
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
            JobsViewController.instantiate()
        }).initCompleted({ (r, view) in
            if let mapViewController = view as? JobsViewController {
                mapViewController.presenter = r.resolve(JobsPresentable.self)!
            }
        }).inObjectScope(.container)
    }
    
    func registerSignUpRouter() {
        container.register(SignUpRouter.self, factory: { r in
            SignUpRouter(signupModuleBuilder: r.resolve(SignUpModuleBuilder.self)!, rootViewController: r.resolve(JobsViewable.self)!)
        }).inObjectScope(.container)
    }
    
}
