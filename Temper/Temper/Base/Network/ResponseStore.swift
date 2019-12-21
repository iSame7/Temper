//
//  ResponseStore.swift
//  TemperTests
//
//  Created by Sameh Mabrouk on 21/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

import Foundation
import Alamofire

public protocol ResponseStore {
    
    func data(for: URLRequest) -> Data
    
    func data(for: URL, withParameters params: Parameters?) -> Data
    
}
