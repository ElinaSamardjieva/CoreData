//
//  ViewController.swift
//  CoreDataProject
//
//  Created by Elina Samardjieva on 4/25/16.
//  Copyright © 2016 Elina Samardjieva. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController {

    @IBOutlet var myLabel: UILabel!
    @IBOutlet var myTextField: UITextField!
    
    var people = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.deleteAllData("Person")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Person")
        
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)

            people = results as! [Person]

            let person = people[people.count - 1]
            myLabel.text = person.name
            
        } catch let error as NSError {
            print("Error")
        }
    }
    
    @IBAction func saveButtonPressed(sender: UIButton) {
            saveName(myTextField!.text!)
        
            let person = people[people.count - 1]
            myLabel.text = person.name
    }
    
    func saveName(name: String) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate        
        let managedContext = appDelegate.managedObjectContext
        
        let entity = NSEntityDescription.entityForName("Person", inManagedObjectContext: managedContext)
        let person = Person(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        person.setValue(name, forKey: "name")
        
        do {
            try managedContext.save()
            people.append(person)
        } catch let error as NSError {
            print("Error")
        }
    }
    
//    func deleteAllData(entity: String)
//    {
//        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//        let managedContext = appDelegate.managedObjectContext
//        let fetchRequest = NSFetchRequest(entityName: entity)
//        fetchRequest.returnsObjectsAsFaults = false
//        
//        do
//        {
//            let results = try managedContext.executeFetchRequest(fetchRequest)
//            for managedObject in results
//            {
//                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
//                managedContext.deleteObject(managedObjectData)
//            }
//        } catch let error as NSError {
//            print("Detele all data in \(entity) error : \(error) \(error.userInfo)")
//        }
//    }
}

