//
//  FeedViewController.swift
//  VKTestM
//
//  Created by Dmitry on 14.08.2021.
//

import UIKit

class AlbumViewController: UICollectionViewController {
    
    private let reuseIdentifier = "cell"
    private var dataFetcher = NetworkDataFetcher(networking: NetworkService())
    
    private let itemsPerRow: CGFloat = 2
    private let sectionInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)

        
//        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
//        layout.itemSize = CGSize(width: 70, height: 30)
//        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
//        layout.minimumLineSpacing = 1
//        layout.minimumInteritemSpacing = 1
//        layout.scrollDirection = .vertical
//
//        collectionView.showsVerticalScrollIndicator = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension AlbumViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCell
        
        dataFetcher.getPhotos { photosResponse in
            guard let photosResponse = photosResponse else { return }
            photosResponse.sizes.map { photosUrl in
                
                guard let url = URL(string: photosUrl.url) else { return }
                URLSession.shared.dataTask(with: url) { data, response, error in
                    if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            cell.photoCell.sizeToFit()
                            cell.photoCell.image = image
                        }
                    }
                }.resume()
            }
        }
        
        return cell
    }
}

extension AlbumViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingWidth = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        sectionInsets.left
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        sectionInsets.left
    }
}

/*
 1. show photos in album
 2. show single photo for another screen
 3. fetch photo
 4. add section with width and hieght
 */
