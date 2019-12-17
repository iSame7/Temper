//
//  JobsViewController.swift
//  Temper
//
//  Created by Sameh Mabrouk on 15/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

import UIKit

class JobsViewController {
    // MARK: - Properties
    
    var presenter: JobsPresentable!
}

// MARK: -
extension JobsViewController: JobsViewable {
    func update(_ jobs: [String : [Job]]) {
        
    }
    
    func showError(error: Error) {
    }
}
