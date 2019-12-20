//
//  UINavigationBar+Extenstions.swift
//  Temper
//
//  Created by Sameh Mabrouk on 20/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

import UIKit.UINavigationBar

extension UINavigationBar {
    func transparent() {
        setBackgroundImage(UIImage(), for: .default)
        shadowImage = UIImage()
        isTranslucent = true
    }
}
