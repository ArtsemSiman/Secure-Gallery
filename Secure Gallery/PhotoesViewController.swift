//
//  PhotoesViewController.swift
//  Secure Gallery
//
//  Created by Артём Симан on 26.04.22.
//

import UIKit

class PhotoesViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var imageBase:ImageBase = ImageBase()
    
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
