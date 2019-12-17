//
//  NSObject+Util.swift
//  Temper
//
//  Created by Sameh Mabrouk on 17/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

import Foundation

public protocol ClassNameProtocol {
    static var className: String { get }
    var className: String { get }
}

public extension ClassNameProtocol {
    static var className: String {
        return String(describing: self)
    }
    
    var className: String {
        return type(of: self).className
    }
}

extension NSObject: ClassNameProtocol {}

public extension NSObjectProtocol {
    var describedProperty: String {
        let mirror = Mirror(reflecting: self)
        return mirror.children.map{ element -> String in
            let key = element.label ?? "Unknown"
            let value = element.value
            return "\(key): \(value)"
            }.joined(separator: "\n")
    }
}
