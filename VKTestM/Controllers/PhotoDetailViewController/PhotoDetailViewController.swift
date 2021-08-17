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
        
        addGesture()
    }
    
    private func addGesture() {
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(didPinch(_:)))
        photoImage.isUserInteractionEnabled = true
        photoImage.addGestureRecognizer(pinchGesture)
    }
    
    @objc private func didPinch(_ gesture: UIPinchGestureRecognizer) {
        let scaleResult = gesture.view?.transform.scaledBy(x: gesture.scale, y: gesture.scale)
        guard let scale = scaleResult, scale.a > 1, scale.d > 1 else { return }
        gesture.view?.transform = scale
        gesture.scale = 1
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
