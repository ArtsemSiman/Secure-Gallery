//
//  PasswordVC.swift
//  Secure Gallery
//
//  Created by Артём Симан on 19.05.22.
//

import UIKit
import Locksmith

class PasswordVC: UIViewController {

    @IBOutlet weak var currentPass: UITextField!
    @IBOutlet weak var newPass: UITextField!
    @IBOutlet weak var repeatPass: UITextField!
    @IBOutlet weak var troubleLabel: UILabel!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBAction func savePassButton(_ sender: Any) {
       
        if let currentPassword = currentPass.text, let newPassword = newPass.text, newPass.text == repeatPass.text {
            do {
                try Locksmith.saveData(data: ["currentPassword" : currentPassword, "newPassword" : newPassword ], forUserAccount: "UserAccount")
            } catch {
                print("Unable to save password")
            }
        }
        checkPass()
    }
        
    func checkPass() {
        if newPass.text != repeatPass.text {
            troubleLabel.alpha = 1
            troubleLabel.text = "Passwords dont match. Try again."
            troubleLabel.textColor = .red

        } else {
            if let resultController = storyboard?.instantiateViewController(withIdentifier: "Main") as? ViewController {
                resultController.modalPresentationStyle = .fullScreen
                navigationController?.viewControllers = [resultController]
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        troubleLabel.alpha = 0
        let dictionary = Locksmith.loadDataForUserAccount(userAccount: "UserAccount")
        print(dictionary ?? "some problem")

    }
}
