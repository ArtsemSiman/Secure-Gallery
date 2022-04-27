//
//  PhotoCollectionViewCell.swift
//  Secure Gallery
//
//  Created by Артём Симан on 26.04.22.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func setupCell(pic: Image){
        self.image.image = pic.image
    }
}
