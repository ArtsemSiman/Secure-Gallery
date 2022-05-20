//
//  PhotoesViewController.swift
//  Secure Gallery
//
//  Created by Артём Симан on 26.04.22.
//

import UIKit
import SwiftUI
import Alamofire


class PhotoesViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var imageArray = FileStorage.getAllImages()
    
    @IBAction func addPhotoButton(_ sender: UIButton) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Library", style: .default) { [weak self] _ in
            self?.openGallery()
        })
        alert.addAction(UIAlertAction(title: "Camera", style: .default) { [weak self] _ in
            self?.openCamera()
        })
        alert.addAction(UIAlertAction(title: "Internet", style: .default) { [weak self] _ in
            self?.openInternet()
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
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PhotoCollectionViewCell
        let photoes = imageArray[indexPath.row]
        cell.setupCell(pic: photoes)
        return cell
    }
  
}

private extension PhotoesViewController {
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

    func openInternet() {
        let alertController = UIAlertController(title: "Write a link to download", message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Download", style: .default) {_ in
            if let textField = alertController.textFields?.first, let text = textField.text {
                self.downloadPicture(pictureUrl: text)
            }
        })
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alertController.addTextField {
            (textField) in
            textField.placeholder = "Write URL"
        }
        
        present(alertController, animated: true)
        
    }
    
    func downloadPicture(pictureUrl: String) {
        AF.request( pictureUrl, method: .get, parameters: nil).responseData {
            [weak self] response in
            if let status = response.response?.statusCode {
                guard (200..<300).contains(status) else {
                    print("Wrong response status: \(status)")
                    return
                }
                let url = URL(string: "\(pictureUrl)")!
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: url) {
                        DispatchQueue.main.async {
                            self?.imageArray
                        }
                    }
                }
            }
        }
    }
}

extension PhotoesViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      if let pickedImage = info[.originalImage] as? UIImage {
          imageArray += [pickedImage]
          FileStorage.saveImage(pickedImage)
          self.collectionView?.reloadData()
      }
      picker.dismiss(animated: true, completion: nil)
  }
}
