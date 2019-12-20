//
//  Presentable.swift
//  Temper
//
//  Created by Sameh Mabrouk on 20/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

import UIKit

protocol Presentable: class {
    func presentInFullScreen(_ viewController: UIViewController,
                             animated: Bool,
    completion: (() -> Void)?)
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?)
    func dismiss(animated flag: Bool, completion: (() -> Void)?)
}
