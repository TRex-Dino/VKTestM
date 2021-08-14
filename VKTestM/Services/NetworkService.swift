//
//  NetworkService.swift
//  VKTestM
//
//  Created by Dmitry on 14.08.2021.
//

import Foundation

protocol Networking {
    func request(path: String, params: [String: String], completion: @escaping (Data?, Error?) -> Void)
}

final class NetworkService: Networking {
    
    private let authService: AuthSerivce
    
    init(authService: AuthSerivce = SceneDelegate.shared().authService) {
        self.authService = authService
    }
    
    func request(path: String, params: [String : String], completion: @escaping (Data?, Error?) -> Void) {
        guard let token = authService.token else { return }
        
        
        var allparams = params
        allparams["access_token"] = token
        allparams["v"] = API.version
        
        let url = self.url(from: path, params: allparams)
        
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
        print(url)
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask{
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
    
    private func url(from path: String, params: [String: String]) -> URL {
        var components = URLComponents()
        
        components.scheme = API.shceme
        components.host = API.host
        components.path = API.newsFeed
        components.queryItems = params.map {
            URLQueryItem(name: $0, value: $1)
        }
        
        let url = components.url!
        return url
    }
}
