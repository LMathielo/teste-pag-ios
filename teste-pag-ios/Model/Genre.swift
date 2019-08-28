//
//  Genre.swift
//  teste-pag-ios
//
//  Created by Lucas Mathielo Gomes on 2019-08-21.
//  Copyright © 2019 Lucas Mathielo Gomes. All rights reserved.
//

import Foundation

struct Genre: Codable {
    let id: Int
    let name: String
}

struct Genres: Codable {
    let genres: [Genre]
}
