//
//  Jobs.swift
//  Temper
//
//  Created by Sameh Mabrouk on 16/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

struct Job: Decodable {
    let title: String
    let location: Location
    let maxPossibleEarningsHour: Double
    let jobCategory: JobCategory
    let shifts: [Shift]
    let client: Client
}
