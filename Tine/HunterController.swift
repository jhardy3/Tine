//
//  HunterController.swift
//  Tine
//
//  Created by Jake Hardy on 3/22/16.
//  Copyright © 2016 NSDesert. All rights reserved.
//

import Foundation

// Class needs to implement functions that will be important for the main functionality of Hunter to Hunter interaction && Hunter to App interaction

class HunterController {
    
    static let sharedInstance = HunterController()
    
    var currentHunter: Hunter?
    
    // MARK: - Authentication && Creation
    
    // Create a new hunter
    
    static func createHunter(username: String, email: String, password: String, completion: (success: Bool) -> Void) {
        
        // Create a user on firebase end
        FirebaseController.firebase.createUser(email, password: password) { (error, data) -> Void in
            if let error = error {
                print(error)
                completion(success: false)
                return
            }
            
            // If successful create Hunter and pass in identifer
            if let authID = data["uid"] as? String {
                var newHunter = Hunter(username: username, identifier: authID)
                newHunter.save()
                self.sharedInstance.currentHunter = newHunter
                completion(success: true)
            } else {
                completion(success: false)
            }
        }
        
    }
    
    // Authenticate a hunter logging in
    
    static func authenticateHunter(email: String, password: String, completion: (hunter: Hunter?) -> Void) {
        FirebaseController.firebase.authUser(email, password: password) { (error, authData) -> Void in
            if let error = error {
                print(error)
                completion(hunter: nil)
                return
            }
            
            guard let hunterID = authData.uid else { completion(hunter: nil) ; return }
            // Fetch hunter right here
            fetchHunterForIdentifier(hunterID, completion: { (hunter) -> Void in
                if let hunter = hunter {
                    completion(hunter: hunter)
                } else {
                    completion(hunter: nil)
                }
            })
        }
    }
    
    // Unauthenticate a hunter logging out
    
    static func unauthHunter() {
        guard var hunter = self.sharedInstance.currentHunter else { return }
        hunter.save()
        FirebaseController.firebase.unauth()
        self.sharedInstance.currentHunter = nil
    }
    
    // MARK: - Fetch Requests
    
    // Grab a single hunter from firebase using an identifier
    
    static func fetchHunterForIdentifier(identifier: String, completion: (hunter: Hunter?) -> Void) {
        FirebaseController.dataAtEndPoint("/hunter/\(identifier)") { (data) -> Void in
            guard let json = data as? [String : AnyObject] else { completion(hunter: nil) ; return }
            
            if let hunter = Hunter(json: json, identifier: identifier) {
                completion(hunter: hunter)
            } else {
                completion(hunter: nil)
            }
            
        }
    }
    
    // Grab multiple hunters from firebase using an array of identifiers
    
    static func fetchHuntersWithIdentifierArray(identifiers: [String], completion: (hunters: [Hunter]) -> Void) {
        var hunterArray = [Hunter]()
        let group = dispatch_group_create()
        

        for hunterID in identifiers {
            dispatch_group_enter(group)
            fetchHunterForIdentifier(hunterID, completion: { (hunter) -> Void in
                if let hunter = hunter {
                    hunterArray.append(hunter)
                }
                dispatch_group_leave(group)
            })
        }
        dispatch_group_notify(group, dispatch_get_main_queue()) { () -> Void in
           completion(hunters: hunterArray)
        }
        
    }
    
    
    
    
    
    
    
    // MARK: - Modify hunter
    
    // Saves existing hunter / overwrites existing hunter with updated hunter
    
    // MARK: - Social Interaction Functions
    
    // Hunter track Hunter
    
    // Hunter untrack Hunter
    
    // MARK: - Query for leaderboard
    
    // Retrieve hunters ordered by shed count
    
    // Retrieve hunters tracked by current hunter ordered by ShedCount
    
}