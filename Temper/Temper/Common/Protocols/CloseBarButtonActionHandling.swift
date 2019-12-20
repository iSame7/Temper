//
//  CloseBarButtonActionHandling.swift
//  Temper
//
//  Created by Sameh Mabrouk on 20/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

import UIKit

@objc protocol CloseBarButtonActionHandling: class {
    func closeButtonTapped()
}

extension CloseBarButtonActionHandling where Self: UIViewController {
    
    func addCloseBarButtonItem() {
        navigationItem.rightBarButtonItem = closeBarButtonItem()
    }
    
    func removeCloseBarButtonItem() {
        navigationItem.rightBarButtonItem = nil
    }
    
    private func closeBarButtonItem() -> UIBarButtonItem {
        let item = UIBarButtonItem(image: UIImage(named: Image.Icon.close),
                                   style: .plain,
                                   target: self,
                                   action: #selector(closeButtonTapped))
        item.tintColor = navigationController?.navigationBar.titleTextAttributes?[.foregroundColor] as? UIColor
        return item
    }
}
