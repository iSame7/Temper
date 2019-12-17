//
//  Jobs.swift
//  Temper
//
//  Created by Sameh Mabrouk on 16/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

struct Job: Decodable {
    let maxPossibleEarningsHour: Double
    let jobCategory: JobCategory
    let shifts: [Shift]
}

struct Client: Decodable {
    let name: String
    let id: String
    let photos: [Photo]
}

struct Photo: Decodable {
    let formats: [PhotoFormat]?
}

struct PhotoFormat: Decodable {
    let cdnUrl: String
}

struct JobCategory: Decodable {
    let description: String
}

struct Shift: Decodable {
    let startTime: String
    let endTime: String
}
