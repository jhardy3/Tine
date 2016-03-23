//
//  Shed.swift
//  Tine
//
//  Created by Jake Hardy on 3/22/16.
//  Copyright © 2016 NSDesert. All rights reserved.
//

import Foundation

class Shed: FirebaseType {
    
    // json dictionary keys
    private let imageKey = "imageIdentifier"
    private let hunterKey = "hunterKey"
    private let messageIdKey = "messagesKey"
    
    // Firebase type identifiers and variables
    var identifier: String?
    var imageIdentifier: String
    var hunterIdentifier: String
    var messageIdentifiers = [String]()
    
    let endpoint = "/shed/"
    
    var jsonValue : [String : AnyObject] {
        return [
            imageKey : imageIdentifier,
            hunterKey : hunterIdentifier,
            messageIdKey : messageIdentifiers.toDic()
        ]
    }
    
    // Firebase Type required initializer
    required init?(json: [String : AnyObject], identifier: String) {
        guard let imageIdentifier = json[imageKey] as? String, hunterIdentifier = json[hunterKey] as? String else {
            self.imageIdentifier = ""
            self.hunterIdentifier = ""
            self.messageIdentifiers = []
            return nil
        }
        
        self.imageIdentifier = imageIdentifier
        self.hunterIdentifier = hunterIdentifier
        if let messages = json[messageIdKey] as? [String : AnyObject] {
            self.messageIdentifiers = Array(messages.keys)
        }
        self.identifier = identifier
    }
    
    // Class Initializer
    init(hunterID: String, imageID: String?) {
        self.hunterIdentifier = hunterID
        self.imageIdentifier = imageID ?? ""
    }
}
