//
//  NibLoadable.swift
//  Temper
//
//  Created by Sameh Mabrouk on 18/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

import UIKit

protocol NibLoadable where Self: UIView {
    func fromNib() -> UIView?
}

extension NibLoadable {
    @discardableResult
    func fromNib() -> UIView? {
        let contentView = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as! UIView
        self.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.edges(to: self)
        return contentView
    }
}
