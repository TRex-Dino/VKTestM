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
    
    private var authService: AuthService!
    
    private let itemsPerRow: CGFloat = 2
    private let sectionInsets = UIEdgeInsets(top: 0, left: 0, bottom: 2, right: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTopBar()
        fetchPhotos()
        
        authService = SceneDelegate.shared().authService
    }
    
    private func setupTopBar() {
        title = "Mobile Up Gallery"
        
        let exitButton = UIBarButtonItem(title: "Выход", style: .plain, target: self, action: #selector(exitButton))
        exitButton.tintColor = .black
        
        self.navigationItem.rightBarButtonItem = exitButton
    }
    
    @objc private func exitButton() {
        authService.authServiceLogOut()
        dismiss(animated: true)
    }
    
    private func fetchPhotos() {
        dataFetcher.getPhotos { photosResponse in
            guard let photos = photosResponse else { return }
            
            let _ = photos.items.map { urlPhotos in
                let lastItem = urlPhotos.sizes.last
                guard let url = lastItem?.url else { return }
                
                let date = urlPhotos.date
                let cell = PhotoViewModel.Cell.init(photoUrlString: url, date: date)
                self.photoViewModel.cells.append(cell)
                self.collectionView.reloadData()
            }
        }
    }
    
    private func dateFormatter(viewController: PhotoDetailViewController, cellViewModel: PhotoViewModel.Cell ) {
        let date = cellViewModel.date
        let currentDate = Date(timeIntervalSince1970: date)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "d MMMM YYYY"
        viewController.navigationItem.title = dateFormatter.string(from: currentDate)
    }
    
    private func backButton() {
        let backButton = UIBarButtonItem(image: nil, style: .plain, target: nil, action: nil)
        backButton.tintColor = .black
        navigationItem.backBarButtonItem = backButton
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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photoDetail = PhotoDetailViewController()
        
        let cellViewModel = photoViewModel.cells[indexPath.row]
        let url = cellViewModel.photoUrlString
        
        photoDetail.photoURL = url
        backButton()
        dateFormatter(viewController: photoDetail, cellViewModel: cellViewModel)
        
        navigationController?.pushViewController(photoDetail, animated: true)
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
