//
//  SharedContainer.swift
//  Temper
//
//  Created by Sameh Mabrouk on 17/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

import Swinject

extension Container {
    static let shared: Container = {
        let c = Container()
        
        c.register(ModuleBuildable.self, factory: { r in
            JobsModuleBuidler(container: c)
        }).inObjectScope(.container)

        return c
    }()
}

