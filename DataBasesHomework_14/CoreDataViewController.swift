//
//  CoreDataViewController.swift
//  DataBasesHomework_14
//
//  Created by Лаура Есаян on 17.12.2019.
//  Copyright © 2019 LY. All rights reserved.
//

import UIKit
import CoreData

class CoreDataViewController: UIViewController {

    @IBOutlet weak var coreDataTableView: UITableView!
    
    @IBOutlet weak var newTaskTextField: UITextField!
    
    var coreDataTasksList = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coreDataTableView.reloadData()
    }
    
    @IBAction func addNewTask(_ sender: Any) {
        if let newTask = newTaskTextField.text {
            saveToCoreData(task: newTask)
            coreDataTableView.reloadData()
            newTaskTextField.text = ""
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Tasks2")
        
        do {
            coreDataTasksList = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }
    
    func saveToCoreData(task: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Tasks2", in: managedContext)!
        
        let tasks = NSManagedObject(entity: entity, insertInto: managedContext)
        
        tasks.setValue(task, forKey: "task2")
        
        do {
            try managedContext.save()
            coreDataTasksList.append(tasks)
            coreDataTasksList.reverse()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func removeTaskFromDataCore(taskToDelete: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext

        let requestToDelete = NSFetchRequest<NSFetchRequestResult>(entityName: "Tasks2")

        requestToDelete.returnsObjectsAsFaults = false

        requestToDelete.predicate = NSPredicate(format: "task2 = %@", "\(taskToDelete)")
        
        do {
            let removingObjects = try managedContext.fetch(requestToDelete)
            for object in removingObjects as! [NSManagedObject] {
                managedContext.delete(object)
            }
        } catch {
            print("Could not delete")
        }
        
        do {
            try managedContext.save()
        } catch {
            print("Could not save deleted process")
        }
    }
}

extension CoreDataViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreDataTasksList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = coreDataTableView.dequeueReusableCell(withIdentifier: "CoreDataCell") as! CoreDataTableViewCell

        cell.coreDataLabel.text = coreDataTasksList[indexPath.row].value(forKey: "task2") as? String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let data = coreDataTasksList[indexPath.row].value(forKey: "task2") as! String
            removeTaskFromDataCore(taskToDelete: data)
            viewWillAppear(true)
            coreDataTableView.reloadData()
        }
    }
    
}
