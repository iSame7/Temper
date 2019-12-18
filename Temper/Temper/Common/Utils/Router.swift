//
//  Router.swift
//  Temper
//
//  Created by Sameh Mabrouk on 17/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

class Router {
    
    private(set) var childRouters: [Router] = []
    
    func start() {
        preconditionFailure("This method needs to be overriden by concrete subclass.")
    }
    
    func stop() {
        preconditionFailure("This method needs to be overriden by concrete subclass.")
    }
    
    func addChildRouter(_ router: Router) {
        childRouters.append(router)
    }
    
    func removeChildRouter(_ router: Router) {
        if let index = childRouters.firstIndex(of: router) {
            childRouters.remove(at: index)
        } else {
            print("Couldn't remove coordinator: \(router). It's not a child coordinator.")
        }
    }
    
    func removeAllChildRoutersWith<T>(type: T.Type) {
        childRouters = childRouters.filter { $0 is T  == false }
    }
    
    func removeAllChildRouters() {
        childRouters.removeAll()
    }
}

extension Router: Equatable {
    static func == (lhs: Router, rhs: Router) -> Bool {
        return lhs === rhs
    }
}
