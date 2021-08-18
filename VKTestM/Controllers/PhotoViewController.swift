//
//  PhotoViewController.swift
//  VKTestM
//
//  Created by Dmitry on 18.08.2021.
//

import UIKit


class PhotoViewController: UIViewController {
    
    @IBOutlet weak var photoImage: WebImageView!
    
    var photoURL: String?
    var photoDate: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPhoto()
        addGesture()
        
        shareButton()
        dateFormatter()
    }
    
    private func dateFormatter() {
        guard let date = photoDate else { return }
        let currentDate = Date(timeIntervalSince1970: date)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: LocalizeString.formatter.setString)
        dateFormatter.dateFormat = "d MMMM YYYY"
        title = dateFormatter.string(from: currentDate)
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
    
    @objc private func loadImage() {
        guard let image = photoImage.image else {
            showAlert(LocalizeString.errorGetPhoto.setString)
            return
        }
        let shareController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        shareController.completionWithItemsHandler = {_, bool, _, error in
            if bool {
                self.showAlert(LocalizeString.savePhoto.setString)
            } else if error != nil {
                self.showAlert(LocalizeString.errorSavePhoto.setString)
            }
        }
        present(shareController, animated: true, completion: nil)
    }
    
    private func showAlert(_ title: String) {
        let ac = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        ac.addAction(ok)
        
        present(ac, animated: true)
    }
}
