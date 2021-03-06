//
//  Meal.swift
//  Food Tracker
//
//  Created by Joseph Maurer on 2/9/18.
//  Copyright © 2018 Joseph Maurer. All rights reserved.
//

import UIKit
import os.log

class Meal: NSObject, NSCoding {
    
    //Mark: Properties
    
    var name: String
    
    var photo: UIImage?
    
    var rating: Int
    
    var mealDescription: String
    
    // Mark: Archiving Paths
    static var DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
    
    // Mark: Types
    
    struct PropertyKey {
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
        static let mealDescription = "mealDescription"
    }
    
    // MarK: Initialization
    
    init?(name: String, photo: UIImage?, rating: Int, mealDescription: String) {
        
        // Initialization should fail if there is no 
        // name or if the rating is negative.
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        
        // The rating must be between 0 and 5 inclusively
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
        
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.rating = rating
        self.mealDescription = mealDescription
    }
    
    // Mark: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(rating, forKey: PropertyKey.rating)
        aCoder.encode(mealDescription, forKey: PropertyKey.mealDescription)
    }

    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String
            else {
                os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
                return nil
        }
        
        // Because photo is an optional property of Meal, just use conditional cast.
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as! UIImage
        
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
        let mealDescription = aDecoder.decodeObject(forKey: PropertyKey.mealDescription) as? String
        
        // Must call designated initializer.
        self.init(name: name, photo: photo, rating: rating, mealDescription: mealDescription!)
        
    }
}
