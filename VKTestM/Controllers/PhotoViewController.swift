//
//  PhotoViewController.swift
//  VKTestM
//
//  Created by Dmitry on 18.08.2021.
//

import UIKit


class PhotoViewController: UIViewController {
    
    @IBOutlet weak var photoImage: WebImageView!
    @IBOutlet weak var photosCollectionView: UICollectionView!
    
    var photoURL: String?
    var photoDate: Double?
    var photoCell: [Cell]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPhoto()
        addGesture()
        
        shareButton()
        dateFormatter()
        
        photosCollectionView.dataSource = self
        photosCollectionView.delegate = self
    }
    
    //MARK: setupInterface
    private func dateFormatter() {
        guard let date = photoDate else { return }
        let currentDate = Date(timeIntervalSince1970: date)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: LocalizeString.formatter.setString)
        dateFormatter.dateFormat = "d MMMM YYYY"
        title = dateFormatter.string(from: currentDate)
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
    
    //MARK: - zoom setting
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
}

//MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension PhotoViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photoCell?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PhotoDetailCell
        
        guard let cells = photoCell else { return cell }
        let cellViewModel = cells[indexPath.row]
        cell.setImage(viewModel: cellViewModel)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedCell = collectionView.cellForItem(at: indexPath) as? PhotoDetailCell else {return}
        
        photoImage.image = selectedCell.photoCell.image
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension PhotoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = photosCollectionView.frame.width / 6.5
        let height = photosCollectionView.frame.height
        
        return CGSize(width: width, height: height)
    }
}
