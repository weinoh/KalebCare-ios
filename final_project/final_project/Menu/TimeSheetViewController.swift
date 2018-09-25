//
//  TimeSheetViewController.swift
//  final_project
//
//  Created by Adam Weintraut on 5/4/18.
//  Copyright © 2018 Adam Weintraut. All rights reserved.
//

import UIKit

class TimeSheetViewController: UIViewController {

    @IBOutlet weak var TimeSheetView: UIView!
    
    @IBOutlet weak var TimeSheetLabel: UILabel!
    @IBOutlet weak var TimeInLabel: UILabel!
    @IBOutlet weak var TimeOutLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    
    @IBOutlet weak var TimeInTextField: UITextField!
    @IBOutlet weak var TimeOutTextField: UITextField!
    @IBOutlet weak var DateTextField: UITextField!
    
    @IBOutlet weak var CancelButton: UIButton!
    @IBOutlet weak var EnterButton: UIButton!
    // Enter Button Pressed Function - Save new timesheet
    @IBAction func EnterPressed(_ sender: UIButton) {
        
        print("Saving the new Hours")
        
        print(TimeInTextField.text)
        print(TimeOutTextField.text)
        print(DateTextField.text)
        print("/////////////////////////////////////////////////////////////////////////////////////")
        if(TimeInTextField.text != nil && DateTextField.text != nil && TimeOutTextField.text != nil){
            
            print("values printed")
            //Specified date format, save as String
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            timeFormatter.dateStyle = .none
            timeFormatter.timeStyle = .short
            let inDate = timeFormatter.date(from: TimeInTextField.text!)!
            let outDate = timeFormatter.date(from: TimeOutTextField.text!)!
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            let date = dateFormatter.date(from: DateTextField.text!)
            // Get information from fields
            let elapsed = outDate.timeIntervalSince(inDate)
            let numHours = Float(elapsed / 3600.0)
            print(numHours)
            // Reset vals
            self.TimeInTextField.text = ""
            self.TimeOutTextField.text = ""
            self.DateTextField.text = ""
            
            if(CoreDataHandler.saveTimesheet(user: currentUser!, numHours: numHours, date: date)){
                print("Properly saved TimeSheet")
                //let timesheets = CoreDataHandler.fetchTimesheet()
            }
        }
    }
    
    let datePicker = UIDatePicker()
    let timePicker = UIDatePicker()
    // User logging their hours
    var currentUser:User?
    
    // FUNCTIONS FOR DATEPICKER
    func createDatePicker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(datePickerDonePressed))
        
        toolbar.setItems([done], animated: false)
        DateTextField.inputAccessoryView = toolbar
        DateTextField.inputView = datePicker
        // Make Picker Purple, worth it??
        datePicker.setValue(UIColor(red: 155/255, green: 89/255, blue: 182/255, alpha: 1), forKeyPath: "textColor")
        datePicker.tintColor = UIColor(red: 155/255, green: 89/255, blue: 182/255, alpha: 1)
        // set mode
        datePicker.datePickerMode = .date
    }
    
    @objc func datePickerDonePressed(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        DateTextField.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    
    // FUNCTIONS FOR TIME IN PICKER
    
    func createTimeInPicker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(timeInPickerDonePressed))
        toolbar.setItems([done], animated: false)
        TimeInTextField.inputAccessoryView = toolbar
        TimeInTextField.inputView = timePicker
        // Make Picker Purple, worth it??
        timePicker.setValue(UIColor(red: 155/255, green: 89/255, blue: 182/255, alpha: 1), forKeyPath: "textColor")
        timePicker.tintColor = UIColor(red: 155/255, green: 89/255, blue: 182/255, alpha: 1)
        // set mode
        timePicker.datePickerMode = .time
    }
    
    @objc func timeInPickerDonePressed(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        TimeInTextField.text = dateFormatter.string(from: timePicker.date)
        self.view.endEditing(true)
    }
    
    
    
    
    
    
    
    // FUNCTIONS FOR TIME OUT PICKER
    
    func createTimeOutPicker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(timeOutPickerDonePressed))
        toolbar.setItems([done], animated: false)
        TimeOutTextField.inputAccessoryView = toolbar
        TimeOutTextField.inputView = timePicker
        // Make Picker Purple, worth it??
        timePicker.setValue(UIColor(red: 155/255, green: 89/255, blue: 182/255, alpha: 1), forKeyPath: "textColor")
        timePicker.tintColor = UIColor(red: 155/255, green: 89/255, blue: 182/255, alpha: 1)
        // set mode
        timePicker.datePickerMode = .time
    }
    
    @objc func timeOutPickerDonePressed(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        TimeOutTextField.text = dateFormatter.string(from: timePicker.date)
        self.view.endEditing(true)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TimeSheetView.layer.cornerRadius = TimeSheetView.frame.height / 5
        CancelButton.layer.cornerRadius = CancelButton.frame.height / 2
        EnterButton.layer.cornerRadius = EnterButton.frame.height / 2
        // Do any additional setup after loading the view.
        createDatePicker()
        createTimeInPicker()
        createTimeOutPicker()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
