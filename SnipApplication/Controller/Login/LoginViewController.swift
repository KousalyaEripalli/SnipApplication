//
//  LoginViewController.swift
//  SnipApplication
//
//  Created by Kousalya Eripalli on 8/11/21.
//

import UIKit
import FirebaseAuth


class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailtxt: UITextField!
    
    @IBOutlet weak var passwordTxt: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
//        fatalError()

        loginBtn.layer.cornerRadius = 20
        loginBtn.layer.borderColor = UIColor.orange.cgColor
        loginBtn.layer.borderWidth = 2
        // Do any additional setup after loading the view.
    }
    

    @IBAction func loginButton(_ sender: UIButton) {
        if (emailtxt.text == "")  || (passwordTxt.text == "") {
            let alert = UIAlertController(title: "EmptyFields", message: "Please fill the text fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }else{
            guard
              let email = emailtxt.text,
              let password = passwordTxt.text,
              !email.isEmpty,
              !password.isEmpty
            else { return }

            Auth.auth().signIn(withEmail: email, password: password) { user, error in
              if let error = error, user == nil {
                let alert = UIAlertController(
                  title: "Sign In Failed",
                  message: error.localizedDescription,
                  preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true, completion: nil)
              }else{
                let st = UIStoryboard.init(name: "Main", bundle: nil)
                let  vc = st.instantiateViewController(withIdentifier: "Age_GenderViewController") as? Age_GenderViewController
                self.navigationController? .pushViewController(vc!, animated: true)
                self.emailtxt.text = ""
                self.passwordTxt.text = ""
                
              }
            }

        }
    }
    
    

}
