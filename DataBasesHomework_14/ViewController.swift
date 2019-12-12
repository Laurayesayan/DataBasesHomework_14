//
//  ViewController.swift
//  DataBasesHomework_14
//
//  Created by Лаура Есаян on 12.12.2019.
//  Copyright © 2019 LY. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var secondNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let firstName = UserDefaultsPersistance.shared.firstName{
            firstNameTextField.text = firstName
        }
        if let secondName = UserDefaultsPersistance.shared.secondName{
            secondNameTextField.text = secondName
        }
    }
    
    @IBAction func enteredFirstName(_ sender: Any) {
        UserDefaultsPersistance.shared.firstName = firstNameTextField.text
    }
    
    @IBAction func enteredSecondName(_ sender: Any) {
        UserDefaultsPersistance.shared.secondName = secondNameTextField.text
    }
    
}

