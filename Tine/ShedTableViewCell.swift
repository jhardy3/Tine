//
//  ShedTableViewCell.swift
//  Tine
//
//  Created by Jake Hardy on 3/22/16.
//  Copyright © 2016 NSDesert. All rights reserved.
//

import UIKit

class ShedTableViewCell: UITableViewCell {

    
    @IBOutlet weak var usernameTextField: UILabel!
    @IBOutlet weak var shedImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func updateWith(image: UIImage, usernameString: String) {
        self.usernameTextField.text = usernameString
        self.shedImageView.image = image
    }
    
    
    
}
