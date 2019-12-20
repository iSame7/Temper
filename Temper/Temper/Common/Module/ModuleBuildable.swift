//
//  ModuleBuildable.swift
//  Temper
//
//  Created by Sameh Mabrouk on 17/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

protocol ModuleBuildable {
    func buildModule() -> Temper.Module?
}

extension ModuleBuildable {
    func buildModule() -> Temper.Module? {
        return nil 
    }
}
