//
//  UIViewController+Presentable.swift
//  Temper
//
//  Created by Sameh Mabrouk on 20/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

import UIKit

extension UIViewController: Presentable {
    func presentInFullScreen(_ viewController: UIViewController,
                             animated: Bool,
                             completion: (() -> Void)? = nil) {
      viewController.modalPresentationStyle = .fullScreen
      present(viewController, animated: animated, completion: completion)
    }
}
