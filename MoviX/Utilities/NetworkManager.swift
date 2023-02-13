//
//  NetworkManager.swift
//  MoviX
//
//  Created by Muhammad Ewaily on 12/02/2023.
//

import Foundation

class NetworkManager {
    static let sharedInstance = NetworkManager()
    
    private init() {}
    
    func request(
        requestModel: RequestModel,
        completionHandler: @escaping (Swift.Result<String, NetworkError>) -> Void
    ) {
        switch requestModel.method {
        case .get:
            makeGetRequest(requestModel: requestModel, completionHandler: completionHandler)
            
        default:
            completionHandler(.failure(.badUrl))
        }
    }
    
    private func makeGetRequest(
        requestModel: RequestModel,
        completionHandler: @escaping (Swift.Result<String, NetworkError>) -> Void
    ) {
        guard let url = URL(string: requestModel.path), var components = URLComponents(string: url.absoluteString) else {
            completionHandler(.failure(.badUrl))
            return
        }
        if let paramters = requestModel.paramters {
            components.queryItems = paramters.map { key, value in
                URLQueryItem(name: key, value: "\(value)")
            }
        }
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = requestModel.method.rawValue
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let safeData = data,
                  let response = response as? HTTPURLResponse,
                  error == nil
            else {
                completionHandler(.failure(.apiFailure))
                return
            }
            
            guard (200 ... 299) ~= response.statusCode else {
                completionHandler(.failure(.apiFailure))
                return
            }
            
            guard let responseString = String(data: safeData, encoding: .utf8) else {
                completionHandler(.failure(.invalidResponse))
                return
            }
            completionHandler(.success(responseString))
        }
        
        task.resume()
    }
}
