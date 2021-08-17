//
//  PhotoCell.swift
//  VKTestM
//
//  Created by Dmitry on 15.08.2021.
//

import UIKit

protocol PhotoCellViewModel {
    var photoUrlString: String { get }
}

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var photoCell: WebImageView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    func setImage(viewModel: PhotoCellViewModel) {
        photoCell.setImageUrl(imageURL: viewModel.photoUrlString)
    }
}
