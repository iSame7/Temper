//
//  String+Extenstions.swift
//  Temper
//
//  Created by Sameh Mabrouk on 19/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

import Foundation

extension String {

    func toDate(withFormat format: String = "yyyy-MM-dd")-> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)

        return date
    }
}
