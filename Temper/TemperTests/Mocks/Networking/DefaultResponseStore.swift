//
//  DefaultResponseStore.swift
//  TemperTests
//
//  Created by Sameh Mabrouk on 21/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

@testable import Temper

import Foundation
import Alamofire

class DefaultResponseStore: ResponseStore {
    
    init() {}
    
    func data(for request: URLRequest) -> Data {
        let path = request.url?.path ?? ""
        return mockData(forPath: path, withParameters: nil)
    }
    
    func data(for url: URL, withParameters params: Parameters?) -> Data {
        return mockData(forPath: url.path, withParameters: params)
    }
    
    func mockData(forPath path: String, withParameters params: Parameters?) -> Data {
        let fileName = "default.json"
        let (resource, fileExtension) = splitFileName(fileName)
        let subDir = mocksDir(forPath: path)
        if let mockUrl = bundle().url(forResource: resource, withExtension: fileExtension) {
            if let mockData = try? Data(contentsOf: mockUrl) {
                return mockData
            }
        }
        let message = "Mock file not found! Path: \(path), Params: \(debugPrint(params ?? [:]))"
        print(message)
        return message.data(using: .utf8)!
    }
    
    private func splitFileName(_ fileName: String) -> (String, String) {
        let components = fileName.split(separator: ".")
        let name = String(describing: components.first ?? "")
        let fileExtension = String(describing: components.last ?? "")
        return (name, fileExtension)
    }
    
    private func mocksDir(forPath path: String) -> String {
        // TODO: add support for nested directories
        return "Fixtures\(path)"
    }
    
    private func loadJSONObject(fromURL url: URL) -> Any? {
        do {
            let data = try Data(contentsOf: url)
            return try JSONSerialization.jsonObject(with: data, options: .allowFragments)
        } catch {
            return nil
        }
    }
    
    private func bundle() -> Bundle {
        // TODO: Come up with a better way to switch bundles when running the tests
        return Bundle(identifier: "com.smapps.TemperTests") ?? Bundle.main
    }
}
