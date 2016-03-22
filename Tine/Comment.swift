//
//  Comment.swift
//  Tine
//
//  Created by Jake Hardy on 3/22/16.
//  Copyright © 2016 NSDesert. All rights reserved.
//

import Foundation

class Comment: FirebaseType {
    
    private let imageKey = "imageIdentifier"
    private let hunterKey = "hunterKey"
    private let bodyTextKey = "bodyTextKey"
    
    var identifier: String?
    
    var imageIdentifier: String
    var hunterIdentifier: String
    var bodyText: String
    
    let endpoint = "/comment/"
    
    var jsonValue : [String : AnyObject] {
        
        return [
            imageKey : imageIdentifier,
            hunterKey : hunterIdentifier,
            bodyTextKey : bodyText
        ]
    }
    
    required init?(json: [String : AnyObject], identifier: String) {
        guard let imageIdentifier = json[imageKey] as? String, hunterIdentifier = json[hunterKey] as? String, let bodyText = json[bodyTextKey] as? String else {
            self.imageIdentifier = ""
            self.hunterIdentifier = ""
            self.bodyText = ""
            return nil
        }
        
        self.imageIdentifier = imageIdentifier
        self.hunterIdentifier = hunterIdentifier
        self.bodyText = bodyText
    }
    
}