//
//  SignUPViewController.swift
//  SnipApplication
//
//  Created by Kousalya Eripalli on 8/11/21.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth


class SignUPViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var firstNameTxt: UITextField!
    
    @IBOutlet weak var lastNameTxt: UITextField!
    
    @IBOutlet weak var emailTxt: UITextField!
    
    @IBOutlet weak var passwordTxt: UITextField!
    
    @IBOutlet weak var submitbtn: UIButton!
    
    @IBOutlet weak var loginWithEmailBtn: UIButton!
    var PersonFullDetails:String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        submitbtn.layer.borderWidth = 2
        submitbtn.layer.borderColor = UIColor.orange.cgColor
        submitbtn.layer.cornerRadius = 20
        
        loginWithEmailBtn.layer.borderWidth = 2
        loginWithEmailBtn.layer.borderColor = UIColor.orange.cgColor
        loginWithEmailBtn.layer.cornerRadius = 20
        
        
    }
//    func didFinishEndEditing(textField: UITextField) {
//        if (firstNameTxt.text?.count ?? 0 >= 8) || (lastNameTxt.text?.count ?? 0 >= 8) || (emailTxt.text?.count ?? 0 >= 8) || (passwordTxt.text?.count ?? 0 >= 8){
//            let alert = UIAlertController(title: "Invalid", message: "Please Enter less than 8 Characters", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//            firstNameTxt.text = ""
//            lastNameTxt.text = ""
//            emailTxt.text = ""
//            passwordTxt.text = ""
//
//        }
//
//    }
    

    @IBAction func submitBtn(_ sender: UIButton) {
        uploadToCloud()
        //let alerts: Bool = true
        
        if (firstNameTxt.text == "") || (lastNameTxt.text == "") || (emailTxt.text == "") || (passwordTxt.text == ""){
            let alert = UIAlertController(title: "Please Enter Text", message: "Please fill all the empty fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            
        }
        else if isEmailValid(emailTxt.text!) == false {
            let alert = UIAlertController(title: "InvalidFormat", message: "Please Enter the email in correct format", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            emailTxt.text = ""
            
        }
       else if (passwordTxt.text?.count ?? 0 < 6){
                    let alert = UIAlertController(title: "Invalid Password", message: "Please Enter more than 6 Characters", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                    passwordTxt.text = ""
//        if isPasswordValid(passwordTxt.text!) == false {
//            let alert = UIAlertController(title: "Invalid Password", message: "Please Enter more than 8 characters", preferredStyle: .alert)
//            alert.addAction( UIAlertAction(title: "OK", style: .default, handler: nil))
//
//            self.present(alert, animated: true, completion: nil)
//            passwordTxt.text = ""
//        }
//        }else if(emailTxt.text == "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
//) || (passwordTxt.text?.count ?? 0 >= 8){
//            let alert = UIAlertController(title: "Invalid", message: "Please Enter less than 8 Characters", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//            emailTxt.text = ""
//            passwordTxt.text = ""
//
//
//        }
        }else {
            
            // 1
            guard
              let email = emailTxt.text,
              let password = passwordTxt.text,
              !email.isEmpty,
              !password.isEmpty
            else { return }

            // 2
            Auth.auth().createUser(withEmail: email, password: password) { _, error in
              // 3
              if error == nil {
                Auth.auth().signIn(withEmail: email, password: password)
              } else {
                print("Error in createUser: \(error?.localizedDescription ?? "")")
              }
            }

            let st = UIStoryboard.init(name: "Main", bundle: nil)
            let  vc = st.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
            navigationController? .pushViewController(vc!, animated: true)
            
            firstNameTxt.text = ""
            lastNameTxt.text = ""
            emailTxt.text = ""
            passwordTxt.text = ""
            
            }
        
        }
    
    func isEmailValid(_ email: String) -> Bool {
        let emailRegEx = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"+"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"+"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"+"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"+"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"+"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"+"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"

        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
//    func isPasswordValid (_ password: String) -> Bool {
//        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$!%*?&]{8,}")
//        return passwordTest.evaluate(with: password)
//    }


    func uploadToCloud() {
        let ref = Database.database().reference()
        
        
        ref.child(firstNameTxt.text!).setValue([
            "Fname": firstNameTxt.text!,
            "Lname": lastNameTxt.text!,
            "email": emailTxt.text!,
            "password": passwordTxt.text!
        ])
        
    }
        
                    
        }
    
    
    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        
//    if (firstNameTxt.text?.count ?? 0 >= 10 || textField == firstNameTxt) {
//        
//        let alert = UIAlertController(title: "My Alert", message: "This is an alert.", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
//        NSLog("The \"OK\" alert occured.")
//        }))
//        self.present(alert, animated: true, completion: nil)
//    }
//
//}

