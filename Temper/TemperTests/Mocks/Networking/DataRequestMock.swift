//
//  DataRequestMock.swift
//  TemperTests
//
//  Created by Sameh Mabrouk on 21/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

@testable import Temper

import Foundation
import Alamofire

class DataRequestMock: DataRequestProtocol {
    
    let data: Data
    
    init(data: Data) {
        self.data = data
    }
    
    @discardableResult
    func response(queue: DispatchQueue?,
                         completionHandler: @escaping (DefaultDataResponse) -> Void) -> Self {
        
        // TODO: ...
        fatalError("response(queue:completionHandler:) has not been implemented")
    }
    
    @discardableResult
    func responseData(queue: DispatchQueue?,
                             completionHandler: @escaping (DataResponse<Data>) -> Void) -> Self {
        // TODO: ...
//        fatalError("responseData(queue:completionHandler:) has not been implemented")
        ///     let result = Result(value: {
          ///         return try someString()
          ///     })
        let result = Result { () -> Data in
            return data
        }
        
        let dataResponse = DataResponse(request: nil, response: nil, data: data, result: result)
          completionHandler(dataResponse)
          return self
    }
    
    @discardableResult
    func responseString(queue: DispatchQueue?,
                               encoding: String.Encoding?,
                               completionHandler: @escaping (DataResponse<String>) -> Void) -> Self {
        // TODO: ...
        fatalError("responseString(queue:encoding:completionHandler:) has not been implemented")
    }
    
    @discardableResult
    func responseJSON(queue: DispatchQueue?,
                      options: JSONSerialization.ReadingOptions,
                      completionHandler: @escaping (DataResponse<Any>) -> Void) -> Self {
        
        let result = Result {
            return try JSONSerialization.jsonObject(with: data, options: options)
        }
        let dataResponse = DataResponse(request: nil, response: nil, data: data, result: result)
        completionHandler(dataResponse)
        return self
    }
    
    @discardableResult
    func responsePropertyList(queue: DispatchQueue?,
                                     options: PropertyListSerialization.ReadOptions,
                                     completionHandler: @escaping (DataResponse<Any>) -> Void) -> Self {
        fatalError("responsePropertyList(queue:options:completionHandler:) has not been implemented")
    }
    
    func cancel() {
        fatalError("cancel() has not been implemented")
    }
    
    @discardableResult
    func downloadProgress(queue: DispatchQueue, closure: @escaping Request.ProgressHandler) -> Self {
        fatalError("downloadProgress(queue: queue, closure: closure) has not been implemented")
    }
}
