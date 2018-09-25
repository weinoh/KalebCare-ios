//
//  LogInViewController.swift
//  final_project
//
//  Created by Adam Weintraut on 4/29/18.
//  Copyright © 2018 Adam Weintraut. All rights reserved.
//

import UIKit


class LogInViewController: UIViewController {

    @IBOutlet weak var UsernameTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var RegisterButton: UIButton!
    @IBOutlet weak var LogInButton: UIButton!
    @IBOutlet weak var InvalidLabel: UILabel!
   
    var currentUser:User?
    
    @IBAction func ButtonLogIn(_ sender: UIButton) {
        let username = UsernameTextField.text!
        let password = PasswordTextField.text!
        let user = CoreDataHandler.findUser(searchString:username)
        UsernameTextField.text = ""
        PasswordTextField.text = ""
        //performSegue(withIdentifier: "LoggedInSegue", sender: self)
        if(user != nil){
            if(user?.password == password){
                currentUser = user
                performSegue(withIdentifier: "LoggedInSegue", sender: self)
            }
            else{
                print("Should be showing ")
                InvalidLabel.isHidden = false
            }
        }
        else{
            InvalidLabel.isHidden = false
        }
    }
    
    // Function to return segues (unwind)
    @IBAction func unwindSegueFromRegister(_ sender: UIStoryboardSegue){
        if sender.source is LogInViewController{
            print("Back to login")
        }
        else{
            // Reload User Table ?
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if(CoreDataHandler.cleanDeleteAll()){
//            print("removed all data")
//        }
        
       // dummyData()
        
        
        
        

        // Customization of Text Fields
        let users = CoreDataHandler.fetchUser()
        if users?.count != 0 {
            RegisterButton.isHidden = true
        }
        else{
            RegisterButton.isHidden = false
        }
        UsernameTextField.layer.borderWidth = 1
        UsernameTextField.layer.borderColor = UIColor.white.cgColor
        UsernameTextField.layer.cornerRadius = UsernameTextField.frame.height / 2.5
        UsernameTextField.clipsToBounds = true
        
        PasswordTextField.layer.borderWidth = 1
        PasswordTextField.layer.borderColor = UIColor.white.cgColor
        PasswordTextField.layer.cornerRadius = PasswordTextField.frame.height / 2.5
        PasswordTextField.clipsToBounds = true
        // Curve Enter Button
        LogInButton.layer.cornerRadius = LogInButton.frame.height / 2.5
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//         Get the new view controller using segue.destinationViewController.
//         Pass the selected object to the new view controller.
        
        if let destination = segue.destination as? MenuTableViewController{
            destination.currentUser = currentUser
        }
        
        if let destination = segue.destination as? RegisterViewController{
            destination.currentSection = "Log In"
        }
    }
    
    
    
    func dummyData(){
        
        if(CoreDataHandler.cleanDeleteAll()){
            print("removed all data")
        }
        
        //////////////////////////////////////
        // DEMO USERS
        /////////////////////////////////////
        if(CoreDataHandler.saveUser(username: "weintraut", password: "weintraut", admin: true, firstName: "Adam", lastName: "Weintraut")){
        print("saved User admin")
        }
        if(CoreDataHandler.saveUser(username: "jboorman", password: "jboorman", admin: false, firstName: "Jackie", lastName: "Boorman")){
        print("saved User Jackie")
        }
        if(CoreDataHandler.saveUser(username: "mulrich", password: "mulrich", admin: false, firstName: "Marjorie", lastName: "Ulrich")){
        print("saved User Marjorie")
        }
        if(CoreDataHandler.saveUser(username: "lgerenz", password: "lgerenz", admin: false, firstName: "Linda", lastName: "Gerenz")){
        print("saved User Linda")
        }
        
        //////////////////////////////////////
        // DEMO MED LIST
        /////////////////////////////////////
        if(CoreDataHandler.saveMed(name: "Artane", dose: "0.4mg/ml", details: "Give 12.5ml (5mg) at 8am, 12pm, and 4pm")){
        print("saved Med Artane")
        }
        if(CoreDataHandler.saveMed(name: "Fluoxetine", dose: "20mg/5ml", details: "Give 7.5ml (30mg) in AM via G-tube")){
        print("saved Med Fluoxetine")
        }
        if(CoreDataHandler.saveMed(name: "Elavil", dose: "25mg", details: "Give 3 tabs (75mg) at 6:30pm daily")){
        print("saved Med Elavil")
        }
        if(CoreDataHandler.saveMed(name: "Lamictal", dose: "100mg", details: "Give 4 tabs (400mg) in AM and give 4 tabs (400mg) in PM (G-tube)")){
        print("saved Med Lamictal")
        }
        if(CoreDataHandler.saveMed(name: "Valium", dose: "1mg/ml", details: "Give 2ml (2mg) at 8am, 4pm, and give 4ml (4mg) at 8pm")){
        print("saved Med Valium")
        }
        if(CoreDataHandler.saveMed(name: "Trileptal", dose: "300mg/5ml", details: "Give 11ml (660mg) in AM, and give 7.5ml (450mg) at 2pm")){
        print("saved Med Trileptal")
        }
        if(CoreDataHandler.saveMed(name: "Neurontin", dose: "250mg/5ml", details: "Give 25ml (1250mg) at 7am, 3pm, and 9pm")){
        print("saved Med Artane")
        }
        
        //////////////////////////////////////
        // DEMO IMPORTANT NOTES
        /////////////////////////////////////
        if(CoreDataHandler.saveNote(title: "Pick Up Artane", date: Date(), details: "Pick up Artane from Walgreens, will be available by 3 pm")){
        print("saved Note 1")
        }
        if(CoreDataHandler.saveNote(title: "Do not give Valium today", date: Date(), details: "Dr. Hocks says to not give Valium today to see effects of new med")){
        print("saved Note 2")
        }
        //////////////////////////////////////
        // DEMO DAILY TASKS
        /////////////////////////////////////
        if(CoreDataHandler.saveTask(name: "Give Kaleb Feeding", time: "7:00 am" , details: "25 ccs of formula through G-tube", done: true)){
        print("saved Task kaleb feeding 1")
        }
        if(CoreDataHandler.saveTask(name: "Get Kaleb into Wheelchair", time: "7:30 am" , details: nil, done: true)){
        print("saved Task kaleb into wheelchair")
        }
        if(CoreDataHandler.saveTask(name: "Change Kaleb's Sheets", time: "8:00 am" , details: nil, done: true)){
        print("saved Task kaleb sheets")
        }
        if(CoreDataHandler.saveTask(name: "Give Kaleb Feeding", time: "11:00 am" , details: "25 ccs of formula through G-tube", done: false)){
        print("saved Task kaleb feeding 2")
        }
        if(CoreDataHandler.saveTask(name: "Get Kaleb out of wheelchair", time: "12:00 pm" , details: "Let Kaleb out to relax at least an hour by now", done: false)){
        print("saved Task kaleb out of wheelchar")
        }
        if(CoreDataHandler.saveTask(name: "Give Kaleb Feeding", time: "3:00 pm" , details: "25 ccs of formula through G-tube", done: false)){
        print("saved Task kaleb feeding 3")
        }
        if(CoreDataHandler.saveTask(name: "Check for BM", time: "4:00 pm" , details: "Check if Kaleb has made B.M. today. If not, give miralax.", done: false)){
        print("saved Task kaleb BM")
        }
        if(CoreDataHandler.saveTask(name: "Give Kaleb Feeding", time: "7:00 pm" , details: "25 ccs of formula through G-tube", done: false)){
        print("saved Task kaleb feeding 4")
        }
        if(CoreDataHandler.saveTask(name: "Give Kaleb Bath", time: "8:00 pm" , details: nil, done: false)){
        print("saved Task kaleb bath")
        }
        if(CoreDataHandler.saveTask(name: "Put on Kaleb's Movie", time: "8:30 pm" , details: "Let Kaleb spend time with his Dad", done: false)){
            print("saved Task kaleb movie")
        }
        if(CoreDataHandler.saveTask(name: "Put Kaleb to Bed", time: "9:30 pm" , details: nil, done: false)){
            print("saved Task kaleb bed")
        }
        //////////////////////////////////////
        // DEMO TIMESHEETS
        /////////////////////////////////////
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        
        // MARJORIE
        var currentUser = CoreDataHandler.findUser(searchString: "mulrich")
        if(CoreDataHandler.saveTimesheet(user: currentUser, numHours: 8, date: formatter.date(from:"04-28-2018"))){
        print("saved Timesheet for ", currentUser?.firstName," ",currentUser?.lastName)
        }
        if(CoreDataHandler.saveTimesheet(user: currentUser, numHours: 5, date: formatter.date(from:"04-30-2018"))){
        print("saved Timesheet for ", currentUser?.firstName," ",currentUser?.lastName)
        }
        if(CoreDataHandler.saveTimesheet(user: currentUser, numHours: 5, date: formatter.date(from:"05-01-2018"))){
        print("saved Timesheet for ", currentUser?.firstName," ",currentUser?.lastName)
        }
        if(CoreDataHandler.saveTimesheet(user: currentUser, numHours: 8, date: formatter.date(from:"05-05-2018"))){
        print("saved Timesheet for ", currentUser?.firstName," ",currentUser?.lastName)
        }
        if(CoreDataHandler.saveTimesheet(user: currentUser, numHours: 7, date: formatter.date(from:"05-10-2018"))){
        print("saved Timesheet for ", currentUser?.firstName," ",currentUser?.lastName)
        }
        if(CoreDataHandler.saveTimesheet(user: currentUser, numHours: 5, date: formatter.date(from:"05-12-2018"))){
        print("saved Timesheet for ", currentUser?.firstName," ",currentUser?.lastName)
        }
        if(CoreDataHandler.saveTimesheet(user: currentUser, numHours: 3, date: formatter.date(from:"05-13-2018"))){
        print("saved Timesheet for ", currentUser?.firstName," ",currentUser?.lastName)
        }
        
        // JACKIE
        currentUser = CoreDataHandler.findUser(searchString: "jboorman")
        if(CoreDataHandler.saveTimesheet(user: currentUser, numHours: 7, date: formatter.date(from:"04-27-2018"))){
        print("saved Timesheet for ", currentUser?.firstName," ",currentUser?.lastName)
        }
        if(CoreDataHandler.saveTimesheet(user: currentUser, numHours: 6, date: formatter.date(from:"04-29-2018"))){
        print("saved Timesheet for ", currentUser?.firstName," ",currentUser?.lastName)
        }
        if(CoreDataHandler.saveTimesheet(user: currentUser, numHours: 8, date: formatter.date(from:"05-02-2018"))){
        print("saved Timesheet for ", currentUser?.firstName," ",currentUser?.lastName)
        }
        if(CoreDataHandler.saveTimesheet(user: currentUser, numHours: 4, date: formatter.date(from:"05-06-2018"))){
        print("saved Timesheet for ", currentUser?.firstName," ",currentUser?.lastName)
        }
        if(CoreDataHandler.saveTimesheet(user: currentUser, numHours: 9, date: formatter.date(from:"05-11-2018"))){
        print("saved Timesheet for ", currentUser?.firstName," ",currentUser?.lastName)
        }
        if(CoreDataHandler.saveTimesheet(user: currentUser, numHours: 7, date: formatter.date(from:"05-14-2018"))){
        print("saved Timesheet for ", currentUser?.firstName," ",currentUser?.lastName)
        }
        if(CoreDataHandler.saveTimesheet(user: currentUser, numHours: 5, date: formatter.date(from:"05-15-2018"))){
        print("saved Timesheet for ", currentUser?.firstName," ",currentUser?.lastName)
        }
        
        // LINDA
        currentUser = CoreDataHandler.findUser(searchString: "lgerenz")
        if(CoreDataHandler.saveTimesheet(user: currentUser, numHours: 9, date: formatter.date(from:"04-25-2018"))){
        print("saved Timesheet for ", currentUser?.firstName," ",currentUser?.lastName)
        }
        if(CoreDataHandler.saveTimesheet(user: currentUser, numHours: 2, date: formatter.date(from:"04-28-2018"))){
        print("saved Timesheet for ", currentUser?.firstName," ",currentUser?.lastName)
        }
        if(CoreDataHandler.saveTimesheet(user: currentUser, numHours: 4, date: formatter.date(from:"05-03-2018"))){
        print("saved Timesheet for ", currentUser?.firstName," ",currentUser?.lastName)
        }
        if(CoreDataHandler.saveTimesheet(user: currentUser, numHours: 8, date: formatter.date(from:"05-04-2018"))){
        print("saved Timesheet for ", currentUser?.firstName," ",currentUser?.lastName)
        }
        if(CoreDataHandler.saveTimesheet(user: currentUser, numHours: 12, date: formatter.date(from:"05-07-2018"))){
        print("saved Timesheet for ", currentUser?.firstName," ",currentUser?.lastName)
        }
        if(CoreDataHandler.saveTimesheet(user: currentUser, numHours: 10, date: formatter.date(from:"05-08-2018"))){
        print("saved Timesheet for ", currentUser?.firstName," ",currentUser?.lastName)
        }
        if(CoreDataHandler.saveTimesheet(user: currentUser, numHours: 8, date: formatter.date(from:"05-16-2018"))){
        print("saved Timesheet for ", currentUser?.firstName," ",currentUser?.lastName)
        }
    }
    

}
