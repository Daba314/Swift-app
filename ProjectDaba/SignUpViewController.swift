//
//  SignUpViewController.swift
//  ProjectDaba
//
//  Created by user198847 on 7/29/21.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailTextBox: UITextField!
    
    @IBOutlet weak var passwordTextBox: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func goToLoginPage(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "Login")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
        
    }
    func allertMessage(){
        let alert = UIAlertController(title: "You have an error", message: "Check out your email format and password(at least 6 letters)", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))

        self.present(alert, animated: true)
        
    }
    
    @IBAction func sigUpButton(_ sender: Any) {
    
        Auth.auth().createUser(withEmail: emailTextBox.text!, password: passwordTextBox.text!) { (authResult, error) in
            if error != nil {
                print("Error \(error!.localizedDescription)")
                self.allertMessage()
            }
            else{
                self.goToLoginPage()
            }
        }
        
        
    }
    
    @IBAction func alreadyButton(_ sender: Any) {
            goToLoginPage()
    }
   
    
   

}
