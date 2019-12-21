//
//  SessionManagerMock.swift
//  TemperTests
//
//  Created by Sameh Mabrouk on 21/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

@testable import Temper

import Foundation
import Alamofire

class SessionManagerMock: SessionManagerProtocol {
    
    let responseStore: ResponseStore
    
    init(responseStore: ResponseStore = DefaultResponseStore()) {
        self.responseStore = responseStore
    }
    
    @discardableResult
    func request(
        _ urlConvertable: URLConvertible,
        method: HTTPMethod,
        parameters: Parameters?,
        encoding: ParameterEncoding,
        headers: HTTPHeaders?) -> DataRequestProtocol {
        
        let url = try! urlConvertable.asURL()
        let data = responseStore.data(for: url, withParameters: parameters)
        return DataRequestMock(data: data)
    }
    
    func request(_ urlRequest: URLRequestConvertible) -> DataRequestProtocol {
        let request = try! urlRequest.asURLRequest()
        let data = responseStore.data(for: request)
        return DataRequestMock(data: data)
    }
    
    @discardableResult
    func download(_ url: URLConvertible,
                  method: HTTPMethod = .get,
                  parameters: Parameters? = nil,
                  encoding: ParameterEncoding = URLEncoding.default,
                  headers: HTTPHeaders? = nil,
                  to destination: DownloadRequest.DownloadFileDestination? = nil) -> DataRequestProtocol {
        
        let url = try! url.asURL()
        let data = responseStore.data(for: url, withParameters: parameters)
        return DataRequestMock(data: data)
    }
    
    @discardableResult
    func download(_ urlRequest: URLRequestConvertible,
                  to destination: DownloadRequest.DownloadFileDestination? = nil) -> DataRequestProtocol {
        let request = try! urlRequest.asURLRequest()
        let data = responseStore.data(for: request)
        return DataRequestMock(data: data)
    }
    
    @discardableResult
    func download(resumingWith resumeData: Data,
                  to destination: DownloadRequest.DownloadFileDestination? = nil) -> DataRequestProtocol {
        fatalError("download(resumingWith:to:) has not been implemented")
    }
    
    // TODO: Add support for more Alamofire API's
}
