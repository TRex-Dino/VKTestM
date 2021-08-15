//
//  AlbumResponse.swift
//  VKTestM
//
//  Created by Dmitry on 15.08.2021.
//

import Foundation

struct AlbumResponse: Decodable {
    let response: PhotosResponse
}

struct PhotosResponse: Decodable {
    let items: [PhotosItem]
}

struct PhotosItem: Decodable {
    let date: Double
    let id: Int
    let sizes: [PhotosUrl]
}

struct PhotosUrl: Decodable {
    let url: String
}
