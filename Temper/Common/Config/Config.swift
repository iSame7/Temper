//
//  Config.swift
//  Temper
//
//  Created by Sameh Mabrouk on 17/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

import Foundation

class Config {
    enum Key: String {
        case baseURL = "BaseURL"
    }
        
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()
    
    private static func value<T>(for key: String) -> T {
        guard let value = infoDictionary[key] as? T else {
            fatalError("\(key) not set in plist as \(T.self)")
        }
        return value
    }
    
    static func string(for key: Config.Key) -> String {
        return value(for: key.rawValue)
    }
}
