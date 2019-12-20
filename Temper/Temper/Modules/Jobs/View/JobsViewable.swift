//
//  JobsViewable.swift
//  Temper
//
//  Created by Sameh Mabrouk on 16/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

protocol JobsViewable: Presentable {
    func update()
    func showError(error: TemperError)
}
