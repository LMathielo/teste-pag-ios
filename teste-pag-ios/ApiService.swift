//
//  ApiService.swift
//  teste-pag-ios
//
//  Created by Lucas Mathielo Gomes on 2019-08-21.
//  Copyright © 2019 Lucas Mathielo Gomes. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct ApiService {
    static func retrieveGenres(completion: @escaping (Genres?) -> Void) {
        Alamofire.request(genre_list_api_url)
            .responseJSON { response in
                let value = JSON(response.result.value!)
                let jsonData = value.description.data(using: .utf8)!
                do {
                    let genre = try! JSONDecoder().decode(Genres.self, from: jsonData)
                    completion(genre)
                }
                catch {
                    print("ERROR IN PARSE")
                }
                
        }
    }
    
    
    static func retrieveMovies(completion: @escaping ([Movie]?) -> Void) {
        Alamofire.request(movie_list_api_url)
            .responseJSON { response in
                let value = JSON(response.result.value!)["results"]
                let jsonData = value.description.data(using: .utf8)!
                do {
                    let genre = try! JSONDecoder().decode([Movie].self, from: jsonData)
                    completion(genre)
                }
                catch {
                    print("ERROR IN PARSE")
                }
                
        }
    }
}
