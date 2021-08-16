//
//  PhotoCell.swift
//  VKTestM
//
//  Created by Dmitry on 15.08.2021.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var photoCell: UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupImage() {
        photoCell.clipsToBounds = true
        photoCell.contentMode = .scaleAspectFill
    }
}
