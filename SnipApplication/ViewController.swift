//
//  ViewController.swift
//  SnipApplication
//
//  Created by Kousalya Eripalli on 8/11/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var signUPbtn: UIButton!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        signUPbtn.layer.cornerRadius = 20
        signUPbtn.layer.borderWidth = 2
        signUPbtn.layer.borderColor = UIColor.orange.cgColor
        
        loginBtn.layer.cornerRadius = 20
        loginBtn.layer.borderWidth = 2
        loginBtn.layer.borderColor = UIColor.orange.cgColor
    }

    
    
}

    
    
    

