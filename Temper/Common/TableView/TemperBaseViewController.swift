//
//  TemperBaseViewController.swift
//  Temper
//
//  Created by Sameh Mabrouk on 17/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

import UIKit.UIViewController

class TemperBaseViewController<T: TemperPresentable>: UIViewController {
    // MARK: - Properties
    var presenter: T
    
    // MARK: - Init    
    init(nibName: String? = nil, presenter: T) {
        self.presenter = presenter
        
        super.init(nibName: nibName, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
