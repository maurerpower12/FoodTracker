//
//  MealTableViewCell.swift
//  Food Tracker
//
//  Created by Joseph Maurer on 2/9/18.
//  Copyright © 2018 Joseph Maurer. All rights reserved.
//

import UIKit


class MealTableViewCell: UITableViewCell {

    // Mark: Properties 
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
