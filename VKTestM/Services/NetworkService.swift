//
//  NetworkService.swift
//  VKTestM
//
//  Created by Dmitry on 14.08.2021.
//

import Foundation

final class NetworkService {
    
    private let authService: AuthSerivce
    
    init(authService: AuthSerivce = SceneDelegate.shared().authService) {
        self.authService = authService
    }
    
    func getFeed() {
        var components = URLComponents()
        guard let token = authService.token else { return }
        
        let params = ["filters": "post,photo"]
        var allparams = params
        allparams["access_token"] = token
        allparams["v"] = API.version
        
        components.scheme = API.shceme
        components.host = API.host
        components.path = API.newsFeed
        components.queryItems = allparams.map {
            URLQueryItem(name: $0, value: $1)
        }
        
        let url = components.url!
        print(url)
    }
}
