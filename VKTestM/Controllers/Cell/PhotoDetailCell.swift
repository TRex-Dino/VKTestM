//
//  PhotoDetailCell.swift
//  VKTestM
//
//  Created by Dmitry on 19.08.2021.
//

import UIKit

class PhotoDetailCell: UICollectionViewCell {
    
    @IBOutlet weak var photoCell: WebImageView!
    
    func setImage(viewModel: PhotoCellViewModel) {
        photoCell.setImageUrl(imageURL: viewModel.photoUrlString)
    }
}
