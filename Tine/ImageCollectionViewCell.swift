//
//  ImageCollectionViewCell.swift
//  Tine
//
//  Created by Jake Hardy on 3/24/16.
//  Copyright © 2016 NSDesert. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var shedImage: UIImageView!
    
    
    func updateWith(shed: Shed) {
        if let shedImage = shed.shedImage {
            self.shedImage.image = shedImage
        }
    }
    
}
