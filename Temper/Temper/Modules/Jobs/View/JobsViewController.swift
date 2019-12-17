//
//  JobsViewController.swift
//  Temper
//
//  Created by Sameh Mabrouk on 15/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

import UIKit

class JobsViewController: UIViewController {
    // MARK: - Properties
    
    var presenter: JobsPresentable!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

// MARK: - StoryboardInstantiatable
extension JobsViewController: StoryboardInstantiatable {
    static var instantiateType: StoryboardInstantiateType {
        return .initial
    }
    
    static var storyboardName: String {
        return StoryboardName.jobs.rawValue
    }
}

// MARK: -
extension JobsViewController: JobsViewable {
    func update(_ jobs: [String : [Job]]) {
        
    }
    
    func showError(error: Error) {
    }
}
