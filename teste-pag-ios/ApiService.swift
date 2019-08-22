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
    static func teste() {
        Alamofire.request(genre_list_api_url).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                print(swiftyJsonVar)
                print("AAAA -> \(swiftyJsonVar.description)")
                if let resData = swiftyJsonVar.arrayObject {
//                    self.arrRes = resData as! [[        ]
                }
            }
        }
    }
    
    static func retrieveGenres(completion: @escaping ([Genre]?) -> Void) {
        Alamofire.request(genre_list_api_url)
            .responseJSON { response in
//                guard response.result.isSuccess,
//                    let value = response.result.value as? String else {
//                        print("Error while fetching tags: \(String(describing: response.result.error))")
//                        completion(nil)
//                        return
//                }
//                let jsonData = JSON(value)["genres"]  //data(using: .utf8)!
                let value = JSON(response.result.value!)["genres"]
                let jsonData = value.description.data(using: .utf8)!
                do {
                    let genre = try! JSONDecoder().decode([Genre].self, from: jsonData)
                    completion(genre)
                }
                catch {
                    print("ERROR IN PARSE")
                }
                
        }
        //                let tags = JSON(value)["genres"].array?.map { json in
        //                    json["id"].intValue
        //                }
        
    }
}
