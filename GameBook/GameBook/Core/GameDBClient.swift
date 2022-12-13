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
    //https://api.rawg.io/api/games?dates=2001-01-01%2C2001-12-31&key=fe45f91792b448b28ce40f115043ee93&ordering=-rating&page=2
        //https://api.rawg.io/api/games?dates=2001-01-01,2001-12-31&ordering=-rating
   // https://api.rawg.io/api/games?dates=2001-01-01,2001-12-31&ordering=-rating&key=fe45f91792b448b28ce40f115043ee93
    //https://api.rawg.io/api/games?key=fe45f91792b448b28ce40f115043ee93&dates=2019-01-01,2019-12-31&ordering=-added
        //https://api.rawg.io/api/games?key=fe45f91792b448b28ce40f115043ee93&dates=2023-01-01,2023-12-31&ordering=-added
        
        case games(Int)
        case ratingSortedGames(Int)
        case popularGames
        case upcomeGames
        case gameDetail(Int)
        
        var stringValue: String {
            switch self {
            case .games(let pageNum):
                return Endpoints.base + "/games" + Constant.API_KEY + "&page=\(pageNum)"
            case .ratingSortedGames(let pageNum):
                return Endpoints.base + "/games" + Constant.API_KEY + "&dates=2001-01-01,2001-12-31&ordering=-rating&page=\(pageNum)"
            case .popularGames:
                return Endpoints.base + "/games" + Constant.API_KEY + "&dates=2001-01-01,2001-12-31&ordering=-added&page=1"
            case .upcomeGames:
                return Endpoints.base + "/games" + Constant.API_KEY + "&dates=2023-01-01,2023-12-31&ordering=-added&page=1"
            case .gameDetail(let id):
                return Endpoints.base + "/games/\(id)" + Constant.API_KEY
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
    
    static func getGamesResponse(pageNum: Int, completion: @escaping (GamesResponseModel?, Error?) -> Void) {
        taskForGETRequest(url: Endpoints.games(pageNum).url, responseType: GamesResponseModel.self) { response, error in
            if let response = response {
                completion(response, nil)
            } else {
                completion(nil, error)
            }
        }
    }
    
    static func getGamesRatingSortedResponse(pageNum: Int, completion: @escaping (GamesResponseModel?, Error?) -> Void) {
        taskForGETRequest(url: Endpoints.ratingSortedGames(pageNum).url, responseType: GamesResponseModel.self) { response, error in
            if let response = response {
                completion(response, nil)
            } else {
                completion(nil, error)
            }
        }
    }
    
    static func getPopularGamesResponse(completion: @escaping (GamesResponseModel?, Error?) -> Void) {
        taskForGETRequest(url: Endpoints.popularGames.url, responseType: GamesResponseModel.self) { response, error in
            if let response = response {
                completion(response, nil)
            } else {
                completion(nil, error)
            }
        }
    }
    static func getUpcomeGamesResponse(completion: @escaping (GamesResponseModel?, Error?) -> Void) {
        taskForGETRequest(url: Endpoints.upcomeGames.url, responseType: GamesResponseModel.self) { response, error in
            if let response = response {
                completion(response, nil)
            } else {
                completion(nil, error)
            }
        }
    }
    
    static func getGameDetail(id: Int,completion: @escaping (GameDetailModel?, Error?) -> Void) {
        taskForGETRequest(url: Endpoints.gameDetail(id).url, responseType: GameDetailModel.self) { response, error in
            if let response = response {
                completion(response, nil)
            } else {
                completion(nil, error)
            }
        }
    }
    

}
