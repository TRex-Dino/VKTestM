//
//  NetworkDataFetcher.swift
//  VKTestM
//
//  Created by Dmitry on 15.08.2021.
//

import Foundation

protocol DataFetcher {
    func getPhotos(response: @escaping (Result<PhotosResponse?, Error>) -> Void)
}

struct NetworkDataFetcher: DataFetcher {
    
    let networking: Networking
    
    init(networking: Networking) {
        self.networking = networking
    }
    
    func getPhotos(response: @escaping (Result<PhotosResponse?, Error>) -> Void) {
        let params = ["owner_id": API.ownerId, "album_id": API.albumId]
        networking.request(path: API.albumPhotos, params: params) { data, error in
            if let error = error {
                response(.failure(error))
            }
            let decoded = self.decodeJSON(type: AlbumResponse.self, from: data)
            response(.success(decoded?.response))
        }
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        
        guard let data = from, let response = try? decoder.decode(type.self, from: data) else { return nil }
        return response
    }
}
