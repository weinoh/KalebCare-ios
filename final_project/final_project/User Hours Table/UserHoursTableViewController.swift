//
//  UserHoursTableViewController.swift
//  final_project
//
//  Created by Adam Weintraut on 5/9/18.
//  Copyright © 2018 Adam Weintraut. All rights reserved.
//

import UIKit

class UserHoursTableViewController: UITableViewController {
    
    @IBOutlet var UserHoursTableView: UITableView!
    
    var userToInspect:User?
    var timesheets = [Timesheet]()
    
    
    
    
    // VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        loadHours()
        // Set Nav Bar title
       // self.navigationItem.title = (userToInspect?.firstName)! + " " + (userToInspect?.lastName)! + " Hours"
        
        // Visual Effects
        UserHoursTableView.backgroundView = UIImageView(image:#imageLiteral(resourceName: "loginbackground"))
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        UserHoursTableView.backgroundView?.addSubview(blurEffectView)
    }
    
    func loadHours(){
        let currentTimesheets = userToInspect?.timesheet
        print("currentTimesheets")
        print(currentTimesheets)
        
        if(currentTimesheets != nil){
            for i in currentTimesheets! {
                print("before conversion")
                timesheets.append(i as! Timesheet)
                print("after conversion")
            }
        }
        
        timesheets = timesheets.sorted(by: { $0.date?.compare($1.date!) == .orderedDescending })
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
        return timesheets.count
    }

    // Set height of each row to fit 6 items on each page
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat((Float(UserHoursTableView.frame.height) / Float(6))-10)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UserHoursTableView.dequeueReusableCell(withIdentifier: "UserHoursTableViewCell", for: indexPath) as! UserHoursTableViewCell

        // Cell Formatting
        cell.UserHoursView.layer.cornerRadius = cell.UserHoursView.frame.height / 2.5
        //cell.MedDetailsLabel.clipsToBounds = true
        
        
        // Fill in cell values
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        cell.DateLabel?.text = formatter.string(from: timesheets[indexPath.row].date!)
        cell.HoursLabel?.text = timesheets[indexPath.row].numHours.description + " hours"
        
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
