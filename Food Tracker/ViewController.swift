//
//  ViewController.swift
//  Food Tracker
//
//  Created by Joseph Maurer on 8/14/17.
//  Copyright © 2017 Joseph Maurer. All rights reserved.
//

import UIKit
import os.log

class ViewController: UIViewController, UITextFieldDelegate,
        UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // Mark: Properties
    
    /*
        implicitly unwrapped optional
     
     An optional that can also be used like a nonoptional value, without the
     need to unwrap the optional value each time it is accessed, because it’s 
     assumed to always have a value after that value is initially set.

     Will always have a value after it is first set due to the ! at the end.
    */
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var ratingControl: RatingControl!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    /*
     This value is either passed by `MealTableViewController` in `prepare(for:sender:)`
     or constructed as part of adding a new meal.
     */
    var meal: Meal?
    
    
    // Mark: UIImagePickerControllerDelegate
    
    // Gets called when a user hits cancel
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss if the user hit 'cancel'
        dismiss(animated: true, completion: nil)
    }
    
    
    //This method gives you a chance to do something with the image or images 
    // that a user selected from the picker. 
    // In your case, you’ll take the selected image and display it in your image view.
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // The info dictionary may contain mutliple representations of the image. Yuo want to use the original.
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as?
        UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set the photoimageview to the selected image
        photoImageView.image = selectedImage
        
        // Dimiss the image picker
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Navigation
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let name = nameTextField.text ?? ""
        let photo = photoImageView.image
        let rating = ratingControl.rating
        
        // Set the meal to be passed to MealTableViewController after the unwind segue.
        meal = Meal(name: name, photo: photo, rating: rating)
    }
    
    
    // Mark: Actions
    
    @IBAction func selectImageFromLibrary(_ sender: UITapGestureRecognizer) {
        // Hide the keyboard just incase
        nameTextField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // only allow images to be picked, not taken
        imagePickerController.sourceType = .photoLibrary
        
        // make sure ViewController is notified when the user picks an image
        imagePickerController.delegate = self
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field's user input through the delegate callbacks
        nameTextField.delegate = self
        
        // Enable the Save button only if the text field has a valid Meal name.
        updateSaveButtonState()
    }

    // Mark: UITextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.isEnabled = false
    }
    
    // Action for when a user presses return or done.s
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hides the keyboard by resigning position as first responder.
        textField.resignFirstResponder()
        
        // Return true because we want the default behavior
        return true
    }
    
    // Action for editing stopped
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    
    //MARK: Private Methods
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
}

