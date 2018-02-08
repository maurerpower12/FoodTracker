//
//  ViewController.swift
//  Food Tracker
//
//  Created by Joseph Maurer on 8/14/17.
//  Copyright © 2017 Joseph Maurer. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    // Mark: Properties
    
    /*
        implicitly unwrapped optional
     
     An optional that can also be used like a nonoptional value, without the
     need to unwrap the optional value each time it is accessed, because it’s 
     assumed to always have a value after that value is initially set.

     Will always have a value after it is first set due to the ! at the end.
    */
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet var mealNameLabel: UILabel!
    
    // Mark: Actions
    
    // This method is an action of type Interface Builder.
    @IBAction func setDefaultLabelText(_ sender: UIButton) {
        mealNameLabel.text = "Default Text"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Handle the text field's user input through the delegate callbacks
        nameTextField.delegate = self
    }

    // Mark: UITextFieldDelegate
    
    // Action for when a user presses return or done.s
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hides the keyboard by resigning position as first responder.
        textField.resignFirstResponder()
        
        // Return true because we want the default behavior
        return true
    }
    
    // Action for editing stopped
    func textFieldDidEndEditing(_ textField: UITextField) {
        mealNameLabel.text = textField.text
    }
}

