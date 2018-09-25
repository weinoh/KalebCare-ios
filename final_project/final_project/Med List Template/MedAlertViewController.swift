//
//  MedAlertViewController.swift
//  final_project
//
//  Created by Adam Weintraut on 4/26/18.
//  Copyright © 2018 Adam Weintraut. All rights reserved.
//

import UIKit

class MedAlertViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var AlertPrompt: UILabel!
    @IBOutlet weak var AlertView: UIView!
    
    @IBOutlet weak var MedNameLabel: UILabel!
    @IBOutlet weak var MedNameTextField: UITextField!
    
    @IBOutlet weak var DosageLabel: UILabel!
    @IBOutlet weak var DosageTextField: UITextField!
    
    @IBOutlet weak var DetailsLabel: UILabel!
    @IBOutlet weak var DetailsTextView: UITextView!
    
    @IBOutlet weak var CancelButton: UIButton!
    @IBOutlet weak var EnterButton: UIButton!
    
    var thisSectionChosen:String?
    
    let picker = UIDatePicker()
    
    @IBAction func MedAlertCancel(_ sender: UIButton) {
        //self.navigationController?.popToViewController(MedListTableViewController:UITableViewController, animated: true)
    }
    
    @IBAction func MedAlertEnter(_ sender: UIButton) {
        // Get information from fields
        let medName = self.MedNameTextField.text!
        let medDosage = self.DosageTextField.text!
        let medDetails = self.DetailsTextView.text!
        // Reset vals
        self.MedNameTextField.text = ""
        self.DosageTextField.text = ""
        self.DetailsTextView.text = ""
        switch thisSectionChosen!{
        case "Current Medications":
            if(CoreDataHandler.saveMed(name: medName, dose: medDosage, details: medDetails)){
                print("Properly saved Med")
            }
            
        case "Important Notes":
            let formatter = DateFormatter()
            formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
            
            //Specified date format, save as String
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            formatter.dateStyle = .medium
            formatter.timeStyle = .none
            let date = formatter.date(from: medDosage)!
            if(CoreDataHandler.saveNote(title: medName, date: date, details: medDetails)){
                print("Properly saved Note")
            }
            return
        case "Daily Tasks":
            print("Daily Tasks")
            if(CoreDataHandler.saveTask(name: medName, time: medDosage, details: medDetails, done: false)){
                print("Properly saved Task")
            }
        default:
            print("whoops")
        }
    }
    
    
    
    func createDatePicker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(datePickerDonePressed))
        toolbar.setItems([done], animated: false)
        DosageTextField.inputAccessoryView = toolbar
        DosageTextField.inputView = picker
        // Make Picker Purple, worth it??
        picker.setValue(UIColor(red: 155/255, green: 89/255, blue: 182/255, alpha: 1), forKeyPath: "textColor")
        picker.tintColor = UIColor(red: 155/255, green: 89/255, blue: 182/255, alpha: 1)
        picker.setValue(true, forKey: "highlightsToday")
        if(currentSection == "Important Notes"){
            picker.datePickerMode = .date
        }
        else{
            picker.datePickerMode = .time
        }
    }
    
    @objc func datePickerDonePressed(){
        let dateFormatter = DateFormatter()
        if(currentSection == "Important Notes"){
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            DosageTextField.text = dateFormatter.string(from: picker.date)
        }
        else{
            dateFormatter.dateStyle = .none
            dateFormatter.timeStyle = .short
            DosageTextField.text = dateFormatter.string(from: picker.date)
        }
        
        self.view.endEditing(true)
        //
    }
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AlertView.layer.cornerRadius = AlertView.frame.height / 5
        CancelButton.layer.cornerRadius = CancelButton.frame.height / 2
        EnterButton.layer.cornerRadius = EnterButton.frame.height / 2
        // Do any additional setup after loading the view.
        switch thisSectionChosen!{
        case "Current Medications":
            AlertPrompt.text = "Enter New Medication"
            MedNameLabel.text = "Medication"
            DosageLabel.text = "Dose (with units)"
            DetailsLabel.text = "Medication Details"
        case "Important Notes":
            AlertPrompt.text = "New Note"
            MedNameLabel.text = "Title"
            DosageLabel.text = "Date"
            createDatePicker()
            DetailsLabel.text = "Details"
        case "Daily Tasks":
            AlertPrompt.text = "New Task"
            MedNameLabel.text = "Task Name"
            DosageLabel.text = "Time"
            createDatePicker()
            DetailsLabel.text = "Details"
        default:
            print("Wrong Identifier")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 

}
