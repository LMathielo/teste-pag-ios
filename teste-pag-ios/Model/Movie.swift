//
//  Movie.swift
//  teste-pag-ios
//
//  Created by Lucas Mathielo Gomes on 2019-08-21.
//  Copyright © 2019 Lucas Mathielo Gomes. All rights reserved.
//

import Foundation

struct Movie: Codable {
    let vote_count: Int
    let id: Int
    let video: Bool
    let vote_average: Int
    let title: String
    let popularity: Double
    let poster_path: String
    let original_language: String
    let original_title: String
    let genre_ids: [Int]
    let backdrop_path: String
    let adult: Bool
    let overview: String
    let release_date: String
}
