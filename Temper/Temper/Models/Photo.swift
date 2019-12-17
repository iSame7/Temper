//
//  Photo.swift
//  Temper
//
//  Created by Sameh Mabrouk on 17/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

struct Photo: Decodable {
    let formats: [PhotoFormat]?
}

struct PhotoFormat: Decodable {
    let cdnUrl: String
}
