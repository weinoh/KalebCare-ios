//
//  CoreDataHandler.swift
//  final_project
//
//  Created by Adam Weintraut on 4/26/18.
//  Copyright © 2018 Adam Weintraut. All rights reserved.
//

import UIKit
import CoreData

class CoreDataHandler: NSObject {
    
    // Retrieve Context Helper Function
    private class func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        return appDelegate.persistentContainer.viewContext
    }
    // End of getContext()
    
    
    
    /////////////////////////////////////////////////////////////////////////////////////////////
    // 1. MEDICATION CORE DATA
    /////////////////////////////////////////////////////////////////////////////////////////////
    
    
    
    
    
    /////////
    // SAVE
    /////////
    class func saveMed(name: String?, dose: String?, details: String?) -> Bool{
        if(name == nil || dose == nil){
            return false
        }
        if((name?.isEmpty)! || (dose?.isEmpty)!){
            return false
        }
        
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "MedEntity", in: context)
        let managedObject = NSManagedObject(entity: entity!, insertInto: context)
        
        managedObject.setValue(name, forKey: "name")
        managedObject.setValue(dose, forKey: "dose")
        managedObject.setValue(details, forKey: "details")
        
        do{
            try context.save()
            return true
            
        }catch{
            return false
        }
    }
    //End of saveMed()
    
    
    
    
    //////////
    // FETCH
    //////////
    class func fetchMed() -> [MedEntity]? {
        let context = getContext()
        var med:[MedEntity]? = nil
        do{
            med = try context.fetch(MedEntity.fetchRequest())
            return med
        }catch{
           return med
        }
    }
    //End of fetchMed()
    
    
    
    
    //////////
    // DELETE
    //////////
    class func deleteMed(med: MedEntity) -> Bool{
        let context = getContext()
        context.delete(med)
        
        do{
            try context.save()
            return true
        }catch{
            return false
        }
    }
    //End of deleteMed()
    
    
    
    
    /////////////////
    // BATCH DELETE
    /////////////////
    class func cleanDeleteMed() -> Bool{
        let context = getContext()
        let delete = NSBatchDeleteRequest(fetchRequest: MedEntity.fetchRequest())
        
        do{
            try context.execute(delete)
            return true
        }catch{
            return false
        }
    }
    //End of cleanDeleteMed()
    
//    /////////////////
//    // FILTER DATA
//    /////////////////
//    class func filterDataMed(searchString: String) -> [MedEntity]? {
//        let context = getContext()
//        let fetchRequest:NSFetchRequest<MedEntity> = MedEntity.fetchRequest()
//        var med:[MedEntity]? = nil
//
//        let predicate = NSPredicate(format: "name contains[c] %@", searchString)
//
//        fetchRequest.predicate = predicate
//        do{
//            med = try context.fetch(fetchRequest)
//            return med
//        }
//        catch{
//            return med
//        }
//    }
//    //End of filterDataMed()
    
    /////////////////
    // FIND
    /////////////////
    class func findMed(searchString: String) -> MedEntity? {
        let context = getContext()
        let fetchRequest:NSFetchRequest<MedEntity> = MedEntity.fetchRequest()
        var med:[MedEntity]?
        
        let predicate = NSPredicate(format: "name == %@", searchString)
        
        fetchRequest.predicate = predicate
        do{
            med = try context.fetch(fetchRequest)
            if(!(med?.isEmpty)!){
                return med?[0]
            }
            else{
                return nil
            }
        }
        catch{
            return nil
        }
    }
    //End of findMed()
    
    
    
    
    /////////////////////////////////////////////////////////////////////////////////////////////
    // 2. NOTE CORE DATA
    /////////////////////////////////////////////////////////////////////////////////////////////
    
    
    
    
    
    /////////
    // SAVE
    /////////
    class func saveNote(title:String?, date: Date?, details: String?) -> Bool{
        // Check for nil values
        if(title == nil || date == nil){
            return false
        }
        
        // Check for empty strings
        if((title?.isEmpty)!){
            return false
        }
        
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Note", in: context)
        let managedObject = NSManagedObject(entity: entity!, insertInto: context)
        
        managedObject.setValue(title, forKey: "title")
        managedObject.setValue(date, forKey: "date")
        managedObject.setValue(details, forKey: "details")
        
        do{
            try context.save()
            return true
            
        }catch{
            return false
        }
    }
    //End of saveNote()
    
    
    
    
    //////////
    // FETCH
    //////////
    class func fetchNote() -> [Note]? {
        let context = getContext()
        var note:[Note]? = nil
        do{
            note = try context.fetch(Note.fetchRequest())
            return note
        }catch{
            return note
        }
    }
    //End of fetchNote()
    
    
    
    
    //////////
    // DELETE
    //////////
    class func deleteNote(note: Note) -> Bool{
        let context = getContext()
        context.delete(note)
        
        do{
            try context.save()
            return true
        }catch{
            return false
        }
    }
    //End of deleteNote()
    
    
    
    
    /////////////////
    // BATCH DELETE
    /////////////////
    class func cleanDeleteNote() -> Bool{
        let context = getContext()
        let delete = NSBatchDeleteRequest(fetchRequest: Note.fetchRequest())
        
        do{
            try context.execute(delete)
            return true
        }catch{
            return false
        }
    }
    //End of cleanDeleteNote()
    
//    /////////////////
//    // FILTER DATA
//    /////////////////
//    class func filterDataNote(searchString: String) -> [Note]? {
//        let context = getContext()
//        let fetchRequest:NSFetchRequest<Note> = Note.fetchRequest()
//        var note:[Note]? = nil
//
//        let predicate = NSPredicate(format: "title contains[c] %@", searchString)
//
//        fetchRequest.predicate = predicate
//        do{
//            note = try context.fetch(fetchRequest)
//            return note
//        }
//        catch{
//            return note
//        }
//    }
//    //End of filterDataNote()
    
    
    
    
    
    /////////////////
    // FIND
    /////////////////
    class func findNote(searchString: String) -> Note? {
        let context = getContext()
        let fetchRequest:NSFetchRequest<Note> = Note.fetchRequest()
        var note:[Note]?
        
        let predicate = NSPredicate(format: "title == %@", searchString)
        
        fetchRequest.predicate = predicate
        do{
            note = try context.fetch(fetchRequest)
            if(!(note?.isEmpty)!){
                return note?[0]
            }
            else{
                return nil
            }
        }
        catch{
            return nil
        }
    }
    //End of findNote()
    
    
    
    /////////////////////////////////////////////////////////////////////////////////////////////
    // 3. TASK CORE DATA
    /////////////////////////////////////////////////////////////////////////////////////////////
    
    
    
    
    
    /////////
    // SAVE
    /////////
    class func saveTask(name:String?, time:String?, details: String?, done:Bool?) -> Bool{
        // Check for nil values
        if(name == nil || time == nil || done == nil){
            return false
        }
        
        // Check for empty strings
        if((name?.isEmpty)! || (time?.isEmpty)!){
            return false
        }
        
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Task", in: context)
        let managedObject = NSManagedObject(entity: entity!, insertInto: context)
        
        managedObject.setValue(name, forKey: "name")
        managedObject.setValue(time, forKey: "time")
        managedObject.setValue(details, forKey: "details")
        managedObject.setValue(done, forKey: "done")
        
        do{
            try context.save()
            return true
            
        }catch{
            return false
        }
    }
    //End of saveTask()
    
    ///////////////
    // EDIT DONE
    ///////////////
    
    class func editTaskDone(done:Bool, task:Task)->Bool{
        let context = getContext()
        
        task.setValue(done, forKey: "done")
        
        do{
            try context.save()
            return true
            
        }catch{
            return false
        }
        
    }
    
    
    //////////
    // FETCH
    //////////
    class func fetchTask() -> [Task]? {
        let context = getContext()
        var task:[Task]? = nil
        do{
            task = try context.fetch(Task.fetchRequest())
            return task
        }catch{
            return task
        }
    }
    //End of fetchTask()
    
    
    
    
    //////////
    // DELETE
    //////////
    class func deleteTask(task: Task) -> Bool{
        let context = getContext()
        context.delete(task)
        
        do{
            try context.save()
            return true
        }catch{
            return false
        }
    }
    //End of deleteTask()
    
    
    
    
    /////////////////
    // BATCH DELETE
    /////////////////
    class func cleanDeleteTask() -> Bool{
        let context = getContext()
        let delete = NSBatchDeleteRequest(fetchRequest: Task.fetchRequest())
        
        do{
            try context.execute(delete)
            return true
        }catch{
            return false
        }
    }
    //End of cleanDeleteTask()
    
//    /////////////////
//    // FILTER DATA
//    /////////////////
//    class func filterDataTask(searchString: String) -> [Task]? {
//        let context = getContext()
//        let fetchRequest:NSFetchRequest<Task> = Task.fetchRequest()
//        var task:[Task]? = nil
//
//        let predicate = NSPredicate(format: "name contains[c] %@", searchString)
//
//        fetchRequest.predicate = predicate
//        do{
//            task = try context.fetch(fetchRequest)
//            return task
//        }
//        catch{
//            return task
//        }
//    }
//    //End of filterDataTask()
    
    
    
    
    
    /////////////////
    // FIND
    /////////////////
    class func findTask(searchString: String) -> Task? {
        let context = getContext()
        let fetchRequest:NSFetchRequest<Task> = Task.fetchRequest()
        var task:[Task]?
        
        let predicate = NSPredicate(format: "name == %@", searchString)
        
        fetchRequest.predicate = predicate
        do{
            task = try context.fetch(fetchRequest)
            if(!(task?.isEmpty)!){
                return task?[0]
            }
            else{
                return nil
            }
        }
        catch{
            return nil
        }
    }
    //End of findTask()
    

    
    
    
    
    
    
    
    
    /////////////////////////////////////////////////////////////////////////////////////////////
    // 4. USER CORE DATA
    /////////////////////////////////////////////////////////////////////////////////////////////
    
    
    
    
    /////////
    // SAVE
    /////////
    class func saveUser(username: String?, password: String?, admin: Bool?, firstName: String?, lastName: String?) -> Bool{
        // Check for nil values
        if(username == nil || password == nil || firstName == nil || lastName == nil || admin == nil){
            return false
        }
        // Check for empty values
        if((username?.isEmpty)! || (password?.isEmpty)! || (firstName?.isEmpty)! || (lastName?.isEmpty)!){
            return false
        }
        
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "User", in: context)
        let managedObject = NSManagedObject(entity: entity!, insertInto: context)
        
        managedObject.setValue(username, forKey: "username")
        managedObject.setValue(password, forKey: "password")
        managedObject.setValue(firstName, forKey: "firstName")
        managedObject.setValue(lastName, forKey: "lastName")
        managedObject.setValue(admin, forKey: "admin")
        
        do{
            try context.save()
            return true
            
        }catch{
            return false
        }
    }
    //End of saveUser()
    
    
    
    ///////////
    // FETCH
    ///////////
    class func fetchUser() -> [User]? {
        let context = getContext()
        var user:[User]? = nil
        do{
            user = try context.fetch(User.fetchRequest())
            return user
        }catch{
            return user
        }
    }
    // End of fetchUser()
    
    
    
    ///////////
    // DELETE
    ///////////
    class func deleteUser(user: User) -> Bool{
        let context = getContext()
        context.delete(user)
        
        do{
            try context.save()
            return true
        }catch{
            return false
        }
    }
    //End of deleteUser()
    
    
    
    /////////////////
    // BATCH DELETE
    /////////////////
    class func cleanDeleteUser() -> Bool{
        let context = getContext()
        let delete = NSBatchDeleteRequest(fetchRequest: User.fetchRequest())
        
        do{
            try context.execute(delete)
            return true
        }catch{
            return false
        }
    }
    //End of cleanDeleteUser()
    
    
    
//    /////////////////
//    // FILTER DATA
//    /////////////////
//    class func filterDataUser(searchString: String) -> [User]? {
//        let context = getContext()
//        let fetchRequest:NSFetchRequest<User> = User.fetchRequest()
//        var user:[User]? = nil
//        
//        let predicate = NSPredicate(format: "lastName contains[c] %@", searchString)
//        
//        fetchRequest.predicate = predicate
//        do{
//            user = try context.fetch(fetchRequest)
//            return user
//        }
//        catch{
//            return user
//        }
//    }
//    //End of filterDataUser()
    
    /////////////////
    // FIND
    /////////////////
    class func findUser(searchString: String) -> User? {
        let context = getContext()
        let fetchRequest:NSFetchRequest<User> = User.fetchRequest()
        var user:[User]?
        
        let predicate = NSPredicate(format: "username == %@", searchString)
        
        fetchRequest.predicate = predicate
        do{
            user = try context.fetch(fetchRequest)
            if(!(user?.isEmpty)!){
                return user?[0]
            }
            else{
                return nil
            }
        }
        catch{
            return nil
        }
    }
    //End of findUser()
    
    
    /////////////////////////////////////////////////////////////////////////////////////////////
    // 5. TIMESHEET CORE DATA
    /////////////////////////////////////////////////////////////////////////////////////////////
    
    
    
    
    /////////
    // SAVE
    /////////
    class func saveTimesheet(user: User?, numHours: Float?, date: Date?) -> Bool{
        if(user == nil || numHours == nil || date == nil){
            return false
        }
        
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Timesheet", in: context)
        let managedObject = NSManagedObject(entity: entity!, insertInto: context)
        
        
        managedObject.setValue(numHours, forKey: "numHours")
        managedObject.setValue(date, forKey: "date")
        managedObject.setValue(user, forKey: "user")
        
        do{
            try context.save()
            return true
            
        }catch{
            return false
        }
    }
    //End of saveTimesheet()
    
    
    
    ///////////
    // FETCH
    ///////////
    class func fetchTimesheet() -> [Timesheet]? {
        let context = getContext()
        var timesheet:[Timesheet]? = nil
        do{
            timesheet = try context.fetch(Timesheet.fetchRequest())
            return timesheet
        }catch{
            return timesheet
        }
    }
    // End of fetchTimesheet()
    
    
    
    ///////////
    // DELETE
    ///////////
    class func deleteTimesheet(timesheet: Timesheet) -> Bool{
        let context = getContext()
        context.delete(timesheet)
        
        do{
            try context.save()
            return true
        }catch{
            return false
        }
    }
    //End of deleteTimesheet()
    
    
    
    /////////////////
    // BATCH DELETE
    /////////////////
    class func cleanDeleteTimesheet() -> Bool{
        let context = getContext()
        let delete = NSBatchDeleteRequest(fetchRequest: Timesheet.fetchRequest())
        
        do{
            try context.execute(delete)
            return true
        }catch{
            return false
        }
    }
    //End of cleanDeleteTimesheet()
    
    
    
//    /////////////////
//    // FILTER DATA
//    /////////////////
//    class func filterDataTimesheet(searchString: String) -> [Timesheet]? {
//        let context = getContext()
//        let fetchRequest:NSFetchRequest<Timesheet> = Timesheet.fetchRequest()
//        var timesheet:[Timesheet]? = nil
//
//        // ???????
//        let predicate = NSPredicate(format: "date >= %@", searchString)
//        //let predicate2 = NSPredicate(format: "t" )
//
//        fetchRequest.predicate = predicate
//        do{
//            timesheet = try context.fetch(fetchRequest)
//            return timesheet
//        }
//        catch{
//            return timesheet
//        }
//    }
//    //End of filterDataUser()
//

    ///////////////////////
    // Get user timesheet
    ///////////////////////
    
    class func getUserTimesheet(user:User) -> NSSet?{
        return user.timesheet
    }
    
    class func cleanDeleteAll()->Bool{
        // DELETE EVERYTHING IF NECESSARY
        let medSuccess = CoreDataHandler.cleanDeleteMed()
        let timeSuccess = CoreDataHandler.cleanDeleteTimesheet()
        let noteSuccess = CoreDataHandler.cleanDeleteNote()
        let userSuccess = CoreDataHandler.cleanDeleteUser()
        let taskSuccess = CoreDataHandler.cleanDeleteTask()
        if(medSuccess && timeSuccess && noteSuccess && userSuccess && taskSuccess){
            return true
        }
        else{
            return false
        }
    }
    
    
}
//End of CoreDataHandler.swift
