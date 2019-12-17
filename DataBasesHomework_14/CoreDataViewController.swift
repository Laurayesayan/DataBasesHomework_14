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
    
    var tasksList: [String] = []
    var coreDataTasksList = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coreDataTableView.reloadData()
    }
    
    @IBAction func addNewTask(_ sender: Any) {
        if let newTask = newTaskTextField.text {
//            tasksList.append(newTask)
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
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}

extension CoreDataViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreDataTasksList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = coreDataTableView.dequeueReusableCell(withIdentifier: "CoreDataCell") as! CoreDataTableViewCell
        
//        cell.coreDataLabel.text = tasksList[indexPath.row]
        cell.coreDataLabel.text = coreDataTasksList[indexPath.row].value(forKey: "task2") as? String
        
        return cell
    }
    
    
}
