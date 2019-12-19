//
//  PullToRefreshActionHandling.swift
//  Temper
//
//  Created by Sameh Mabrouk on 19/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

import UIKit

@objc protocol PullToRefreshActionHandling: class {
    var pullTpRefreshControl: UIRefreshControl? { get set }
    func refreshControlValueChanged()
}

extension PullToRefreshActionHandling where Self: UIViewController {
    
    func addRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlValueChanged), for: .valueChanged)
        pullTpRefreshControl = refreshControl
    }
    
    func endRefreshingIfNeeded() {
        if pullTpRefreshControl?.isRefreshing ?? false {
            pullTpRefreshControl?.endRefreshing()
        }
    }
}
