//
//  JSONDecoder+Extenstions.swift
//  Temper
//
//  Created by Sameh Mabrouk on 17/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//
import Foundation
import Alamofire

/// Generic function to handle Alamofire responses into our Codable types until Alamofire support it.
/// https://github.com/Alamofire/Alamofire/issues/2180
extension JSONDecoder {
    func decodeResponse<T: Decodable>(from response: DataResponse<Data>) -> Result<T> {
        if let error = response.error {
            if error._code == -1009 {
                return .failure(TemperError.noInternetConnection)
            } else {
                return .failure(TemperError.noResponse)
            }
        } else {
            guard let responseData = response.data else {
                return .failure(TemperError.JSONParsing)
            }
            
            do {
                let item = try decode(T.self, from: responseData)
                return .success(item)
            } catch {
                return .failure(TemperError.JSONParsing)
            }
        }
    }
}
