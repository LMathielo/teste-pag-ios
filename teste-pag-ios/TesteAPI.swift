


typealias ResultCallback<Value> = (Result<Value, Error>) -> Void
protocol APIClient {
    func send<T: APIRequest>(
        _ request: T,
        completion: @escaping ResultCallback<Result<T.Response, Error>>
    )
}


protocol APIRequest: Encodable {
    associatedtype Response: Decodable
    associatedtype Filter: Encodable
    
    func applyFilters(filter: Filter) -> Filter
}

struct GetGenders<filter: Encodable>: APIRequest {
    typealias Response = Genres
    typealias Filter = Genre //Will work?
    
    var apiUrl: String {
        return genre_list_api_url
    }
    
    // Filters
    let name: String?
    let nameStartsWith: String?
    let limit: Int?
    let offset: Int?
    
    init(name: String? = nil,
         nameStartsWith: String? = nil,
         limit: Int? = nil,
         offset: Int? = nil) {
        self.name = name
        self.nameStartsWith = nameStartsWith
        self.limit = limit
        self.offset = offset
    }
    
    func toList(item: Response) -> [Genre] {
        return item.genres
    }
    
    func applyFilters(filter: Filter) -> Filter {
        return filter
    }
//
//    func toArray() -> [Genre] {
//        if let resp = Response() {
//
//        }
//    }
}

import Foundation

struct teste {
    
    let apiClient = MarvelAPIClient()
    
}

struct MarvelAPIClient {
    func send<T: APIRequest>(_ request: T, completion: @escaping ResultCallback<T>) {
        
        
        let endpoint = genre_list_api_url ///v1/public/characters//self.endpoint(for: request)
        
        let filter = T.applyFilters(request)
        
        let url1 = URL(string: endpoint)!
        let ulr2 = URLRequest(url: url1)
//        let url3 = URLSession()
//        let url4 = URLSession().dataTask(with: ulr2)
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: URL(string: endpoint)!)) { data, response, error in
            if let data = data {
                do {
                    let response = try JSONDecoder().decode(DataResponse<T.Response>.self, from: data)
                    
                    if let dataContainer = response.data {
//                        completion(Result.success(dataContainer))
                        print(dataContainer)
                    } else if let message = response.message {
//                        completion(.failure( fatalError())) //MarvelError.server(message: message)))
                    } else {
//                        completion(.failure(fatalError()))//MarvelError.decoding))
                    }
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
}




struct DataResponse<Response: Decodable>: Decodable {
    let status: String?
    let message: String?
    let data: Response?
}
