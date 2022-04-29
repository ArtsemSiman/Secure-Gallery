//
//  Photofiles.swift
//  Secure Gallery
//
//  Created by Артём Симан on 26.04.22.
//

import Foundation
import UIKit

class ImageBase {
    
    var images = [UIImage?]()
    init() {
        setup()
    }
    
    func setup() {
    let im1 = UIImage(named:"0")
    let im2 = UIImage(named:"1")
    let im3 = UIImage(named:"2")
    let im4 = UIImage(named:"3")
    let im5 = UIImage(named:"4")
    let im6 = UIImage(named:"5")
    let im7 = UIImage(named:"6")
    let im8 = UIImage(named:"7")
    let im9 = UIImage(named:"8")
    let im10 = UIImage(named:"9")
    self.images = [im1, im2, im3, im4, im5, im6, im7, im8, im9, im10]
}
}
