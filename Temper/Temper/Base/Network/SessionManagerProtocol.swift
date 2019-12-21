//
//  SessionManagerProtocol.swift
//  TemperTests
//
//  Created by Sameh Mabrouk on 21/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

import Foundation
import Alamofire

protocol SessionManagerProtocol {
    
    @discardableResult
    func request(_ url: URLConvertible, method: HTTPMethod, parameters: Parameters?,
                 encoding: ParameterEncoding, headers: HTTPHeaders?)  -> DataRequestProtocol
    
    func request(_ urlRequest: URLRequestConvertible) -> DataRequestProtocol
    
    //
    // Download
    //
    
    @discardableResult
    func download(_ url: URLConvertible,
                    method: HTTPMethod,
                    parameters: Parameters?,
                    encoding: ParameterEncoding,
                    headers: HTTPHeaders?,
                    to destination: DownloadRequest.DownloadFileDestination?) -> DataRequestProtocol
    
    @discardableResult
    func download(_ urlRequest: URLRequestConvertible,
                    to destination: DownloadRequest.DownloadFileDestination?) -> DataRequestProtocol
    
    @discardableResult
    func download(resumingWith resumeData: Data,
                    to destination: DownloadRequest.DownloadFileDestination?) -> DataRequestProtocol
    
}

extension SessionManagerProtocol {
    
    @discardableResult
    public func request(
        _ url: URLConvertible,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil) -> DataRequestProtocol {
        
        return request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
    }
    
    //
    // Download
    //
    
    @discardableResult
    func download(_ url: URLConvertible,
                  method: HTTPMethod = .get,
                  parameters: Parameters? = nil,
                  encoding: ParameterEncoding = URLEncoding.default,
                  headers: HTTPHeaders? = nil,
                  to destination: DownloadRequest.DownloadFileDestination? = nil) -> DataRequestProtocol {
        return download(url, method: method, parameters: parameters, encoding: encoding, headers: headers, to: destination)
    }
    
    @discardableResult
    func download(_ urlRequest: URLRequestConvertible,
                  to destination: DownloadRequest.DownloadFileDestination? = nil) -> DataRequestProtocol {
        return download(urlRequest, to: destination)
    }
    
    @discardableResult
    func download(resumingWith resumeData: Data,
                  to destination: DownloadRequest.DownloadFileDestination? = nil) -> DataRequestProtocol {
        return download(resumingWith: resumeData, to: destination)
    }
}

extension SessionManager: SessionManagerProtocol {
    
    @discardableResult
    func request(_ url: URLConvertible, method: HTTPMethod, parameters: Parameters?,
                 encoding: ParameterEncoding, headers: HTTPHeaders?)  -> DataRequestProtocol {
        let dataRequest: DataRequest = request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
        return dataRequest as DataRequestProtocol
    }
    
    func request(_ urlRequest: URLRequestConvertible) -> DataRequestProtocol {
        let dataRequest: DataRequest = request(urlRequest)
        return dataRequest as DataRequestProtocol
    }
}
