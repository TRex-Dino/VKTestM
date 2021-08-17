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
    private var photoViewModel = PhotoViewModel.init(cells: [])
    
    private let itemsPerRow: CGFloat = 2
    private let sectionInsets = UIEdgeInsets(top: 0, left: 0, bottom: 2, right: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTopBar()
        fetchPhotos()
    }
    
    private func setupTopBar() {
        title = "Mobile Up Gallery"
        
        let exitButton = UIBarButtonItem(title: "Выход", style: .plain, target: nil, action: nil)
        exitButton.tintColor = .black
        
        self.navigationItem.rightBarButtonItem = exitButton
    }
    
    private func fetchPhotos() {
        dataFetcher.getPhotos { photosResponse in
            guard let photos = photosResponse else { return }
            
            photos.items.map { urlPhotos in
                let lastItem = urlPhotos.sizes.last
                guard let url = lastItem?.url else { return }
                
                let cell = PhotoViewModel.Cell.init(photoUrlString: url)
                self.photoViewModel.cells.append(cell)
                self.collectionView.reloadData()
            }
        }
    }
}

// MARK: - collectionView setting
extension AlbumViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photoViewModel.cells.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCell
        let cellViewModel = photoViewModel.cells[indexPath.row]
        cell.setImage(viewModel: cellViewModel)
        
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension AlbumViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingWidth = sectionInsets.bottom
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        sectionInsets.bottom
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        sectionInsets.bottom
    }
}

/*
 1. show photos in album
 2. show single photo for another screen
 3. fetch photo
 4. add section with width and hieght
 */
