//
//  Photofiles.swift
//  Secure Gallery
//
//  Created by Артём Симан on 26.04.22.
//

import Foundation
import UIKit

struct Image{
    var image:UIImage
}
class ImageBase {
    
    var images = [Image]()
    init() {
        setup()
    }
    
    func setup() {
    let Im1 = Image(image: UIImage(named:"0")!)
    let Im2 = Image(image: UIImage(named:"1")!)
    let Im3 = Image(image: UIImage(named:"2")!)
    let Im4 = Image(image: UIImage(named:"3")!)
    let Im5 = Image(image: UIImage(named:"4")!)
    let Im6 = Image(image: UIImage(named:"5")!)
    let Im7 = Image(image: UIImage(named:"6")!)
    let Im8 = Image(image: UIImage(named:"7")!)
    let Im9 = Image(image: UIImage(named:"8")!)
    let Im10 = Image(image: UIImage(named:"9")!)
    self.images = [Im1, Im2, Im3, Im4, Im5, Im6, Im7, Im8, Im9, Im10]
}
}
