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
    private var authService: AuthService!
    
    private var photoViewModel = PhotoViewModel(cells: [])
    
    private let itemsPerRow: CGFloat = 2
    private let sectionInsets = UIEdgeInsets(top: 0, left: 0, bottom: 2, right: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTopBar()
        fetchPhotos()
        
        authService = SceneDelegate.shared().authService
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPhoto" {
            
            guard let items = collectionView.indexPathsForSelectedItems?.first else { return }
            guard let item = items.last else { return }
            let photoVC = segue.destination as! PhotoVC
            photoVC.photoURL = photoViewModel.cells[item].photoUrlString
            photoVC.photoDate = photoViewModel.cells[item].date
        }
    }
    
    private func setupTopBar() {
        title = "Mobile Up Gallery"
        
        let exitButton = UIBarButtonItem(title: "Выход", style: .plain, target: self, action: #selector(exitButton))
        exitButton.tintColor = .black
        navigationItem.rightBarButtonItem = exitButton
        
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        backButton.tintColor = .black
        navigationItem.backBarButtonItem = backButton
    }
    
    @objc private func exitButton() {
        authService.authServiceLogOut()
        dismiss(animated: true)
    }
    
    private func fetchPhotos() {
        dataFetcher.getPhotos { photoResponse in
            guard let photo = photoResponse else { return }
            
            for item in photo.items {
                let lastItemSize = item.sizes.last
                guard let url = lastItemSize?.url else { return }
                
                let date = item.date
                let cell = PhotoViewModel.Cell(photoUrlString: url, date: date)
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
