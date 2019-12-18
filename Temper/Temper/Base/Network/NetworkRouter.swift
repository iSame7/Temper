//
//  NetworkRouter.swift
//  Temper
//
//  Created by Sameh Mabrouk on 16/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

import Alamofire

enum NetworkRouter: URLRequestConvertible {
    case fetchJobs(dates: String)
    
    static let baseURLString = Constants.baseURL
    
    var method: HTTPMethod {
        switch self {
        case .fetchJobs:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .fetchJobs:
            return "contractor/shifts"
        }
    }
    
    var parameters: [String: AnyObject]? {
        switch self {
        case let .fetchJobs(dates):
            return ["dates": dates] as [String: AnyObject]?
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try NetworkRouter.baseURLString.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        print("URL: \(String(describing: urlRequest.url))")
        return urlRequest
    }
}
