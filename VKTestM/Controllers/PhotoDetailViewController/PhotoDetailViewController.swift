//
//  PhotoDetailViewController.swift
//  VKTestM
//
//  Created by Dmitry on 17.08.2021.
//

import UIKit

class PhotoDetailViewController: UIViewController {

    @IBOutlet weak var photoImage: WebImageView!
    
    var photoURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPhoto()
        shareButton()
    }
    
    private func setPhoto() {
        guard let photo = photoURL else { return }
        photoImage.setImageUrl(imageURL: photo)
    }
    
    private func shareButton() {
        let shareButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(loadImage))
        self.navigationItem.rightBarButtonItem = shareButton
        shareButton.tintColor = .black
    }
    
    @objc func loadImage() {
        guard let image = photoImage.image else { return }
        let shareController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(shareController, animated: true, completion: nil)
    }
}
