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
    
    func addCloseBarButtonItem(imageName: String = Image.Icon.close) {
        navigationItem.rightBarButtonItem = closeBarButtonItem(imageName: imageName)
    }
    
    func removeCloseBarButtonItem() {
        navigationItem.rightBarButtonItem = nil
    }
    
    private func closeBarButtonItem(imageName: String) -> UIBarButtonItem {
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage(named: imageName), for: .normal)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        
        return UIBarButtonItem(customView: button)
    }
}
