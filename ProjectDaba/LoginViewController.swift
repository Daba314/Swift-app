//
//  LoginViewController.swift
//  ProjectDaba
//
//  Created by user198847 on 7/29/21.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextBox: UITextField!
    
    @IBOutlet weak var passwordTextBox: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButton(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextBox.text!, password: passwordTextBox.text!) { (authResult, error) in
            if error != nil {
                print("Error \(error!.localizedDescription)")
                //self.allertMessage()
            }
            else{
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(identifier: "Table")
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
            }
        }
      
        
    }
    
    @IBAction func createAccountButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "SignUp")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
        
    }

}
