//
//  MenuTableViewController.swift
//  final_project
//
//  Created by Adam Weintraut on 4/23/18.
//  Copyright © 2018 Adam Weintraut. All rights reserved.
//
import Foundation
import UIKit

var currentSection = ""

class MenuTableViewController: UITableViewController {
   
    // MARK: - Outlets
    @IBOutlet var mainTableView: UITableView!
   
    // REST OF OUTLETS -- CustomTableViewCell.swift
    
    
    // VARS for Menu Items and corresponding views
    var menuItems = [Menu]()
    var tableSegues = ["Current Medications", "Important Notes", "Completed Tasks Record", "Daily Tasks", "Nurse Management"]
    var menuNames = ["Current Medications", "Important Notes", "Daily Tasks", "Completed Tasks Record", "Punch In/Out","Time Off Request", "Nurse Management"]
    var sectionChosen = ""
    var currentUser:User?
    
    // Function to return segues (unwind) to main menu
    @IBAction func unwindSegueMenu(_ sender: UIStoryboardSegue){
        if sender.source is TimeSheetViewController{
            print("TimeSheet")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMenuItems()
        //CoreDataHandler.cleanDeleteTimesheet()
        print("///////////////////////////////////////////////////////////////////")
        print("\n")
        //print(CoreDataHandler.fetchTimesheet())
        print("current user timesheets")
        //print(CoreDataHandler.getUserTimesheet(user: currentUser!))
        // Uncomment the following line to preserve selection between presentations
        //self.clearsSelectionOnViewWillAppear = false

        // Visual Effects
        mainTableView.backgroundView = UIImageView(image:#imageLiteral(resourceName: "loginbackground"))
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mainTableView.backgroundView?.addSubview(blurEffectView)
    }
   
    
    func loadMenuItems() {
        var currentMenu = [ Menu(name: menuNames[0], image: #imageLiteral(resourceName: "icons8-pill-bottle-filled-50")),
                            Menu(name: menuNames[1], image: #imageLiteral(resourceName: "icons8-documents-filled-50")),
                            Menu(name: menuNames[2], image: #imageLiteral(resourceName: "icons8-todo-list-filled-50")),
//                            Menu(name: menuNames[3], image: #imageLiteral(resourceName: "icons8-checklist-50")),
                            Menu(name: menuNames[4], image: #imageLiteral(resourceName: "icons8-clock-50"))
        ]
        
        if(currentUser?.admin)!{
            currentMenu.append(Menu(name: menuNames[6], image: #imageLiteral(resourceName: "icons8-user-groups-filled-50")))
        }
//        else{
//            
//            currentMenu.append(Menu(name: menuNames[5], image: #imageLiteral(resourceName: "icons8-schedule-filled-50")))
//        }
        
    
        
        for menuItem in currentMenu {
            if let menuItem = menuItem {
                menuItems.append(menuItem)
            }
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
        return menuItems.count
    }

    
    // Height of each row, set dynamically
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(((Float(mainTableView.frame.height) / Float(menuItems.count)) - 20)) // 10 is spacing between each
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        mainTableView.isScrollEnabled = false;
        let cell = mainTableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
        // Round edges
        cell.cellView.layer.cornerRadius = cell.cellView.frame.height / 2.5
        // Fill in cell values
        cell.mainmenuLabel?.text = menuItems[indexPath.row].name
        sectionChosen = menuItems[indexPath.row].name
        cell.iconImage?.image = menuItems[indexPath.row].image
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        currentSection = menuItems[indexPath.row].name
        print(currentSection)
        if(tableSegues.contains(currentSection)){
            print("Selected into tableview")
            performSegue(withIdentifier: "TableSegue", sender: self)
        }
        if(currentSection == "Punch In/Out"){
            performSegue(withIdentifier: "TimeClockSegue", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MedListTableViewController{
            destination.sectionChosen = currentSection
        }
        if let destination = segue.destination as? RegisterViewController{
            destination.currentSection = currentSection
        }
        if let destination = segue.destination as? TimeSheetViewController{
            destination.currentUser = currentUser
        }
    }


}
