//
//  Persistance.swift
//  DataBasesHomework_14
//
//  Created by Лаура Есаян on 12.12.2019.
//  Copyright © 2019 LY. All rights reserved.
//

import Foundation
import RealmSwift

class UserDefaultsPersistance {
    static let shared = UserDefaultsPersistance()
    
    private let kUserFirstNameKey = "UserDefaultsPersistance.kUserFirstNameKey"
    private let kUserSecondNameKey = "UserDefaultsPersistance.kUserSecondNameKey"
    
    var firstName: String? {
        set {
            UserDefaults.standard.set(newValue, forKey: kUserFirstNameKey)
        } get {
            UserDefaults.standard.string(forKey: kUserFirstNameKey)
        }
    }
    
    var secondName: String? {
        set {
            UserDefaults.standard.set(newValue, forKey: kUserSecondNameKey)
        } get {
            UserDefaults.standard.string(forKey: kUserSecondNameKey)
        }
    }
}

class Tasks: Object {
    @objc dynamic var task = ""
}

class RealmPersistance {
    static let shared = RealmPersistance()
    private var newTask = ""
    private var tasksList: [String] = []
    
    private let realm = try! Realm()
    
    func getRecoordedTask() -> [String] {
        tasksList = []
        for t in realm.objects(Tasks.self) {
            tasksList.append(t.task)
        }
        
        return tasksList.reversed()
    }
    
    func setTask(newTask: String) {
        self.newTask = newTask
    }

    func recordTask() {
        try! realm.write {
            let task = Tasks()
            task.task = newTask
            realm.add(task)
        }
    }
    
    func deleteTask(toDelete: String) {
        for task in realm.objects(Tasks.self) {
            if toDelete == task.task {
                try! realm.write {
                    realm.delete(task)
                }
            }
        }
        
        tasksList = []
    }
    

}
