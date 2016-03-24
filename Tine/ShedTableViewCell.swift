//
//  ShedTableViewCell.swift
//  Tine
//
//  Created by Jake Hardy on 3/22/16.
//  Copyright © 2016 NSDesert. All rights reserved.
//

import UIKit

class ShedTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet weak var usernameTextField: UILabel!
    @IBOutlet weak var shedImageView: UIImageView!
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // MARK: - UI Updating Functions
    
    // Update View with passed in shed
    func updateWith(shed: Shed) {
        
        // If shed image exists, set shedImageView to image
        if let shedImage = shed.shedImage {
            self.shedImageView.image = shedImage
        }
        
        // Set usernameTextField text to passed in shed username
        self.usernameTextField.text = shed.hunterIdentifier
    }
}
