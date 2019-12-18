//
//  TemperData.swift
//  Temper
//
//  Created by Sameh Mabrouk on 17/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

struct TemperData: Decodable {
    var periods: [String: [Job]]
    
    private struct CustomCodingKeys: CodingKey {
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        var intValue: Int?
        init?(intValue: Int) {
            return nil
        }
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CustomCodingKeys.self)

        self.periods = [String: [Job]]()
        for key in container.allKeys {
            let value = try container.decode([Job].self, forKey: CustomCodingKeys(stringValue: key.stringValue)!)
            self.periods[key.stringValue] = value
        }
    }
}
