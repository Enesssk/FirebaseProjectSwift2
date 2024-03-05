//
//  ViewController.swift
//  FireBaseProjectSwift2
//
//  Created by Enes Kala on 5.03.2024.
//

import UIKit
import Firebase
import FirebaseAuth



class ViewController: UIViewController {

    
    
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signInButtonClicked(_ sender: Any) {
        
        if emailText.text == "" && passwordText.text == "" {
            self.makeAlert(titleInput: "Error", messageInput: "Please enter a password or email")
        } else {
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { response, error in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                } else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        }
        
    }
    
    
    
    @IBAction func signUpButtonClicked(_ sender: Any) {
        
        if emailText.text == "" && passwordText.text == "" {
            self.makeAlert(titleInput: "Error", messageInput: "Please enter a password or email")
        }else{
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { response, error in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                } else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        }
        
        
    }
    
    func makeAlert(titleInput : String, messageInput : String) {
        
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        
        self.present(alert, animated: true)
        
    }
}

