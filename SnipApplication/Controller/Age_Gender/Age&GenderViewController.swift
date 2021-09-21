//
//  Age&GenderViewController.swift
//  SnipApplication
//
//  Created by Kousalya Eripalli on 8/20/21.
//

import UIKit

class Age_GenderViewController: UIViewController {

    @IBOutlet weak var ageText: UITextField!
    
    @IBOutlet weak var genderText: UITextField!
    
    @IBOutlet weak var skipButton: UIButton!
    
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        skipButton.layer.cornerRadius = 20
        skipButton.layer.borderColor = UIColor.orange.cgColor
        skipButton.layer.borderWidth = 2
        
        submitButton.layer.cornerRadius = 20
        submitButton.layer.borderColor = UIColor.orange.cgColor
        submitButton.layer.borderWidth = 2
        
        
    }
    

}
