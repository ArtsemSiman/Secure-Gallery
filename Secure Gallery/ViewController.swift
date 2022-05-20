//
//  ViewController.swift
//  Secure Gallery
//
//  Created by Артём Симан on 25.04.22.
//

import UIKit
import Kingfisher
import SwiftKeychainWrapper


class ViewController: UIViewController {
    
    let correctPassword = "123"

    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var checkPassowrd: UILabel!
    @IBOutlet weak var enterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordText.text = ""
//        enterButton.isEnabled = true
        checkPassowrd.alpha = 0
    }

    @IBAction func enterButton(_ sender: Any) {
        if passwordText.text == "123" {
            if let resultController = storyboard?.instantiateViewController(withIdentifier: "Photos") as? PhotoesViewController {
                resultController.modalPresentationStyle = .fullScreen
                navigationController?.viewControllers = [resultController]
            }
            
            checkPassowrd.alpha = 1
            
            
        } else{
            checkPassowrd.alpha = 1
            checkPassowrd.text = "Incorrect password. Try again"
            passwordText.text = ""
//            enterButton.isEnabled = false
        }
    }
    
}

