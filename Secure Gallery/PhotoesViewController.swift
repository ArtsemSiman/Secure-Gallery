//
//  PhotoesViewController.swift
//  Secure Gallery
//
//  Created by Артём Симан on 26.04.22.
//

import UIKit

class PhotoesViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func addPhotoButton(_ sender: UIButton) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Library", style: .default) { [weak self] _ in
            self?.openGallery()
        })
        alert.addAction(UIAlertAction(title: "Camera", style: .default) { [weak self] _ in
            self?.openCamera()
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
    }
    
    var imageBase: ImageBase = ImageBase()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.register(UINib(nibName: "PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        self.collectionView.dataSource = self
        self.collectionView.delegate = self

    }
}

extension PhotoesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageBase.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PhotoCollectionViewCell
        let photoes = imageBase.images[indexPath.row]
        cell.setupCell(pic: photoes)
        return cell
    }
  
}

private extension UIViewController {
    func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: "Warning", message: "You don't have permission to access gallery.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension UIViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      if let pickedImage = info[.originalImage] as? UIImage {
          FileStorage.saveImage(pickedImage, withName: "some photo")
      }
      picker.dismiss(animated: true, completion: nil)
  }
}
