//
//  Persistance.swift
//  DataBasesHomework_14
//
//  Created by Лаура Есаян on 12.12.2019.
//  Copyright © 2019 LY. All rights reserved.
//

import Foundation

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
