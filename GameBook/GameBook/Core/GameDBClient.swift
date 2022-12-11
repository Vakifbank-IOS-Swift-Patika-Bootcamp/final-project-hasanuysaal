//
//  GameDBClient.swift
//  GameBook
//
//  Created by Hasan Uysal on 11.12.2022.
//

import Foundation

class GameDBClient {
    
    enum Endpoints {
        static let base = "https://api.rawg.io/api"
        
        case games
        
        var stringValue: String {
            switch self {
            case .games:
                return Endpoints.base + "/games" + Constant.API_KEY
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    @discardableResult
    static func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                
            }
        }
        task.resume()
        return task
    }
    
    static func getGamesResponse(completion: @escaping (GamesResponseModel?, Error?) -> Void) {
        taskForGETRequest(url: Endpoints.games.url, responseType: GamesResponseModel.self) { response, error in
            if let response = response {
                completion(response, nil)
            } else {
                completion(nil, error)
            }
        }
    }
}
