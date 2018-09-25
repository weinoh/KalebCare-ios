//
//  MedAlertViewController.swift
//  final_project
//
//  Created by Adam Weintraut on 4/26/18.
//  Copyright © 2018 Adam Weintraut. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    

    @IBOutlet weak var RegisterView: UIView!
    
    // Text Fields
    @IBOutlet weak var FirstNameText: UITextField!
    @IBOutlet weak var LastNameText: UITextField!
    
    @IBOutlet weak var UsernameText: UITextField!
    @IBOutlet weak var PasswordText: UITextField!
    // Labels
    @IBOutlet weak var RegisterLabel: UILabel!
    
    @IBOutlet weak var UsernameLabel: UILabel!
    @IBOutlet weak var PasswordLabel: UILabel!
    
    @IBOutlet weak var LastNameLabel: UILabel!
    @IBOutlet weak var FirstNameLabel: UILabel!
    
    // Buttons
    @IBOutlet weak var CancelButton: UIButton!
    @IBOutlet weak var EnterButton: UIButton!
    
    
    @IBAction func EnterPressed(_ sender: UIButton) {
        
        // Get information from fields
        let firstName = self.FirstNameText.text!
        let lastName = self.LastNameText.text!
        let username = self.UsernameText.text!
        let password = self.PasswordText.text!
        // Reset vals
        self.FirstNameText.text = ""
        self.LastNameText.text = ""
        self.UsernameText.text = ""
        self.PasswordText.text = ""
       
        if(CoreDataHandler.saveUser(username: username, password: password, admin: true, firstName: firstName, lastName: lastName)){
            print("Properly saved User")
        }
    }
    
    var currentSection:String?
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RegisterView.layer.cornerRadius = RegisterView.frame.height / 5
        CancelButton.layer.cornerRadius = CancelButton.frame.height / 2
        EnterButton.layer.cornerRadius = EnterButton.frame.height / 2
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
}
