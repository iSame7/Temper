//
//  TemperPresentable.swift
//  Temper
//
//  Created by Sameh Mabrouk on 17/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

protocol TemperPresentable: class {
    var title: String? { get }
}

extension TemperPresentable {
    var title: String? {
        return nil
    }
}
