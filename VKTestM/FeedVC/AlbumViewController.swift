//
//  FeedViewController.swift
//  VKTestM
//
//  Created by Dmitry on 14.08.2021.
//

import UIKit

class AlbumViewController: UICollectionViewController {
    
    private let networkService = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBlue
        let params = ["owner_id": API.ownerId, "album_id": API.albumId]
        networkService.request(path: API.albumPhotos,
                               params: params) { data, error in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
            }
            
            guard let data = data else { return }
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            print("json \(json!)")
        }
    }
}
