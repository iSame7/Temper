//
//  TemperError.swift
//  Temper
//
//  Created by Sameh Mabrouk on 17/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

import Foundation

enum TemperError: Error {
    case JSONParsing
    case noResponse
    case noInternetConnection
}

// MARK: - Error Descriptions
extension TemperError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .JSONParsing:
            return NSLocalizedString("Didn't get any data from API", comment: "Parsing Error")
        case .noResponse:
            return NSLocalizedString("No respose from server", comment: "Server Error")
        case .noInternetConnection:
            return NSLocalizedString("The Internet connection appears to be offline.", comment: "no internet connection")
        }
    }
}

// MARK: - Error MetaData
extension TemperError: CustomNSError {
    public static var errorDomain: String {
        return "com.foursquare.error"
    }
    
    public var errorCode: Int {
        switch self {
        case .JSONParsing:
            return 1001
        case .noResponse:
            return 1002
        case .noInternetConnection:
            return -1009
        }
    }
    
    public var errorUserInfo: [String: Any] {
        switch self {
        case .JSONParsing:
            return [NSLocalizedDescriptionKey: "No data from server"]
        case .noResponse:
            return [NSLocalizedDescriptionKey: "No respose from server"]
        case .noInternetConnection:
            return [NSLocalizedDescriptionKey: "No internet connection"]
        }
    }
}
