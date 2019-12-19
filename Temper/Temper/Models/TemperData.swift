//
//  TemperData.swift
//  Temper
//
//  Created by Sameh Mabrouk on 17/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

struct TemperData: Decodable {
    var periods: [String: [Job]]
    
    private struct CustomCodingKeys: CodingKey, Comparable {
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }

        var intValue: Int?
        init?(intValue: Int) {
            return nil
        }
        
        public static func < (lhs: CustomCodingKeys, rhs: CustomCodingKeys) -> Bool {
            return lhs.stringValue < rhs.stringValue
        }
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CustomCodingKeys.self)

        periods = [String: [Job]]()
        for key in container.allKeys.sorted() {
            guard let customeCodingkey = CustomCodingKeys(stringValue: key.stringValue) else {
                return
            }
            
            let value = try container.decode([Job].self, forKey: customeCodingkey)
            periods[key.stringValue] = value
        }
    }
}
