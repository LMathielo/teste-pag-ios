

//TODO: Implementar um callback com Result Type
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
    
    func applyFilters(filter: Filter) -> Filter {
        return filter
    }
}

import Foundation

struct MarvelAPIClient {
    func send<T: APIRequest>(_ request: T, completion: @escaping (DataResponse<T.Response>) -> Void) {
        
        let endpoint = "\(genre_list_api_url)"
        let filter = T.applyFilters(request)
        let dataResponse = DataResponse<T.Response>()
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: URL(string: endpoint)!)) { data, response, error in
            
            if let response = response as? HTTPURLResponse {
                dataResponse.status = response.statusCode
            }
            if let data = data {
                do {
                    let aresponse = try JSONDecoder().decode(T.Response.self, from: data)
                    dataResponse.data = aresponse
                    completion(dataResponse)
//                    completion(.success(Result<DataResponse<T.Response>, Error>(dataResponse, nil)))
                } catch {
                    dataResponse.message = error.localizedDescription
                    dataResponse.status = 500 //forcando status por conta do json deserialization failure
//                    completion(.failure(error))
                    completion(dataResponse)
                    
                }
            } else if let error = error {
//                completion(.failure(error))
                if let response = response as? HTTPURLResponse {
                    dataResponse.status = response.statusCode
                }
                dataResponse.message = error.localizedDescription
                completion(dataResponse)
            }
        }
        task.resume()
    }
}

//NOT BEST IMPLEMENTATION?
class DataResponse<Response: Decodable>: Decodable {
    var status: Int?
    var message: String?
    var data: Response?
}
