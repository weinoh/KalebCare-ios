//
//  medListTBVC.swift
//  final_project
//
//  Created by Adam Weintraut on 4/25/18.
//  Copyright © 2018 Adam Weintraut. All rights reserved.
//
import Foundation
import UIKit


class MedListTableViewController: UITableViewController, ChangeCheckBox {
    
    // MARK: - Outlets
    @IBOutlet var medTableView: UITableView!
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        if(currentSection == "Nurse Management"){
            performSegue(withIdentifier: "UserAddSegue", sender: self)
        }
        else{
            performSegue(withIdentifier: "TableAddSegue", sender: self)
        }
    }
    
    
    
    
    
    var sectionChosen:String?
    var userToInspect:User?
    
    // Vars for Menu Items and corresponding views
    var items = [NSObject]()
    var meds = [MedEntity]()
    var notes = [Note]()
    var tasks = [Task]()
    var users = [User]()
    
    
    // Vars to send in Segue to detail view
    var medName:String = ""
    var medDetails:String = ""
    var medDosage:String = ""
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        medTableView.backgroundView = UIImageView(image: UIImage(named: "loginbackground.jpg"))
        
        // Visual Effects
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        medTableView.backgroundView?.addSubview(blurEffectView)
        
        // Load Table Items
        loadItems()
        // Set Nav Bar title
        self.navigationItem.title = sectionChosen
    }
    //End viewDidLoad()
    

    // Load Table Items dependent on choice
    func loadItems() {
        switch sectionChosen!{
        case "Current Medications":
            let medEntities = CoreDataHandler.fetchMed()
            meds.removeAll()
    
            if(medEntities != nil){
                for i in medEntities! {
                    meds.append(i)
                }
            }
        case "Important Notes":
            let noteEntities = CoreDataHandler.fetchNote()
            notes.removeAll()
            
            if(noteEntities != nil){
                for i in noteEntities! {
                    notes.append(i)
                }
            }
        case "Daily Tasks":
            let taskEntities = CoreDataHandler.fetchTask()
            tasks.removeAll()

            if(taskEntities != nil){
                for i in taskEntities! {
                    tasks.append(i)
                }
            }
        case "Nurse Management":
            let userEntities = CoreDataHandler.fetchUser()
            users.removeAll()
            
            if(userEntities != nil){
                for i in userEntities! {
                    users.append(i)
                }
            }
        default:
            print("oops !")
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch sectionChosen!{
        case "Current Medications":
           return meds.count
        case "Important Notes":
           return notes.count
        case "Daily Tasks":
            return tasks.count
        case "Nurse Management":
            return users.count
        default:
            return items.count
        }
    }
    
    
    // Set height of each row to fit 6 items on each page
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat((Float(medTableView.frame.height) / Float(6))-10)
    }
    
    
    // Cell Values
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get Table Cell
        let cell = medTableView.dequeueReusableCell(withIdentifier: "medListCell", for: indexPath) as! MedTableViewCell
       
        // Cell Formatting
        cell.MedCellView.layer.cornerRadius = cell.MedCellView.frame.height / 2.5
        cell.MedDetailsLabel.clipsToBounds = true
        
        // Fill in cell values
        switch sectionChosen!{
        case "Current Medications":
            cell.CheckButton.isHidden = true
            cell.MedLabel?.text = meds[indexPath.row].name
            cell.DosageLabel?.text = meds[indexPath.row].dose
            cell.MedDetailsLabel?.text = meds[indexPath.row].details
        case "Important Notes":
            cell.CheckButton.isHidden = true
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .none
            cell.MedLabel?.text = notes[indexPath.row].title
            cell.DosageLabel?.text = formatter.string(from: notes[indexPath.row].date!)
            cell.MedDetailsLabel?.text = notes[indexPath.row].details
        case "Daily Tasks":
            cell.CheckButton.isHidden = false
            if tasks[indexPath.row].done {
                cell.CheckButton.setBackgroundImage(#imageLiteral(resourceName: "icons8-checked-checkbox-26"), for: UIControlState.normal)
            }
            else{
                cell.CheckButton.setBackgroundImage(#imageLiteral(resourceName: "icons8-unchecked-checkbox-26"), for: UIControlState.normal)
            }
            
            cell.delegate = self
            cell.indexP = indexPath.row
            cell.tasks = tasks
            // CHANGE CHECK BUTTON IMAGE !!!!!
            cell.MedLabel?.text = tasks[indexPath.row].name
            cell.DosageLabel?.text = tasks[indexPath.row].time!
            cell.MedDetailsLabel?.text = tasks[indexPath.row].details
        case "Nurse Management":
            cell.CheckButton.isHidden = true
            cell.MedLabel?.text = users[indexPath.row].firstName! + " " + users[indexPath.row].lastName!
            let currentUserTimesheets = users[indexPath.row].timesheet
            let today = Date()
            var numHoursForWeek:Float
            numHoursForWeek = 0.0
            if(currentUserTimesheets != nil){
                for i in currentUserTimesheets! {
                    let timesheet = i as! Timesheet
                    let elapsed = today.timeIntervalSince(timesheet.date!)
                    let daysElapsed = Float(elapsed / 86400)
                    if(daysElapsed < 14){
                        numHoursForWeek += timesheet.numHours
                    }
                }
            }
            cell.MedDetailsLabel?.text = numHoursForWeek.description + " hours in past 2 weeks"
            
            if users[indexPath.row].admin {
                cell.DosageLabel?.text = "Admin"
            }
            else{
                cell.DosageLabel?.text = ""
            }
            
        default:
            cell.MedLabel?.text = ""
            cell.DosageLabel?.text = ""
            cell.MedDetailsLabel?.text = ""
        }
        
        return cell
        
    }
    
    
    
    // FUNCTION TO EDIT DONE
    func changeCheckBox(done: Bool, index: Int) {
        let currTask = CoreDataHandler.findTask(searchString: tasks[index].name!)
        if(CoreDataHandler.editTaskDone(done: done, task: currTask!)){
            print("saved status successfully")
            medTableView.reloadData()
        }
    }
    
    
    // Get values for specific row selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        // Load vars to be used in prepare for segue
        switch sectionChosen!{
        case "Current Medications":
            medName = meds[indexPath.row].name!
            medDosage = meds[indexPath.row].dose!
            medDetails = meds[indexPath.row].details!
            performSegue(withIdentifier: "MedTableDetailSegue", sender: self)
        case "Important Notes":
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .none
            medName = notes[indexPath.row].title!
            medDosage = formatter.string(from: notes[indexPath.row].date!)
            medDetails = notes[indexPath.row].details!
            performSegue(withIdentifier: "MedTableDetailSegue", sender: self)
        case "Daily Tasks":
            medName = tasks[indexPath.row].name!
            medDosage = tasks[indexPath.row].time!
            medDetails = tasks[indexPath.row].details!
            performSegue(withIdentifier: "MedTableDetailSegue", sender: self)
        case "Nurse Management":
            medName = users[indexPath.row].firstName! + " " + users[indexPath.row].lastName!
            userToInspect = users[indexPath.row]
            if users[indexPath.row].admin {
                medDosage = "Admin"
            }
            else{
                medDosage = ""
            }
            medDetails = "Fill in hour numbers here"
            performSegue(withIdentifier: "ShowUserHoursSegue", sender: self)
        default:
            medName = ""
            medDosage = ""
            medDetails = ""
            performSegue(withIdentifier: "MedTableDetailSegue", sender: self)
        }
        //Send to Detail Screen if row selected
//        performSegue(withIdentifier: "MedTableDetailSegue", sender: self)
    }

    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            switch sectionChosen!{
            case "Current Medications":
                if(CoreDataHandler.deleteMed(med:meds[indexPath.row])){
                    self.meds.remove(at: indexPath.row)
                }
            case "Important Notes":
                if(CoreDataHandler.deleteNote(note:notes[indexPath.row])){
                    self.notes.remove(at: indexPath.row)
                }
            case "Daily Tasks":
                if(CoreDataHandler.deleteTask(task:tasks[indexPath.row])){
                    self.tasks.remove(at: indexPath.row)
                }
            case "Nurse Management":
                if(CoreDataHandler.deleteUser(user:users[indexPath.row])){
                    self.users.remove(at: indexPath.row)
                }
            default:
                print("Can't delete")
            }
            
            self.tableView.deleteRows(at: [indexPath], with: .fade)
//            self.medTableView.reloadData()
//            self.medTableView.setNeedsDisplay()
        }
    }
    
    // Function to return segues (unwind)
    @IBAction func unwindSegueFromMedAlert(_ sender: UIStoryboardSegue){
        if sender.source is MedAlertViewController{
            loadItems()
            medTableView.reloadData()
        }
        
        if sender.source is NewUserViewController{
            loadItems()
            medTableView.reloadData()
        }
    }
    
    // Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MedTableDetailsViewController{
            destination.thisMedName = medName
            destination.thisMedDosage = medDosage
            destination.thisMedDetails = medDetails
            destination.thisSectionChosen = sectionChosen
        }
        
        if let secondDestination = segue.destination as? MedAlertViewController{
            secondDestination.thisSectionChosen = sectionChosen
        }
        
        if let thirdDestination = segue.destination as? UserHoursTableViewController{
            thirdDestination.userToInspect = userToInspect
        }
    }
    
}
