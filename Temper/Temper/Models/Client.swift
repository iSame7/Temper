//
//  Client.swift
//  Temper
//
//  Created by Sameh Mabrouk on 17/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

struct Client: Decodable {
    let name: String
    let id: String
    let photos: [Photo]
}
