//
//  ShedController.swift
//  Tine
//
//  Created by Jake Hardy on 3/22/16.
//  Copyright © 2016 NSDesert. All rights reserved.
//

import Foundation
import UIKit
// Class will implement functions to control shed posts in area

class ShedController {
    
    // MARK: - Post Creation and deletion ( modification )
    
    // Create new shed
    static func createShed(image: UIImage, hunterIdentifier: String, completion: (success: Bool) -> Void) {
        
        // guard for current hunter or complete false and return
        guard var currentHunter = HunterController.sharedInstance.currentHunter else { completion(success: false) ; return }
        
        // Upload the image to S3 and receive a specific url back if successful
        PhotoController.sharedInstance.uploadImageToS3(image) { (url) -> () in
            
            // Check for url
            if let url = url {
                
                // If URL is present instantiate a Shed and save it.
                var shed = Shed(hunterID: hunterIdentifier, imageID: url)
                shed.save()
                
                // Check for obviously present identifier
                guard let shedID = shed.identifier else { completion(success: false) ; return }
                
                // Add Shed ID to currentHunters Shed IDs and save it
                currentHunter.shedIDs.append(shedID)
                currentHunter.save()
                
                // Complete true
                completion(success: true)
            } else {
                
                // If url is not present complete false
                completion(success: false)
            }
        }
    }
    
    // Delete post
    static func deleteShed(shed : Shed) {
        
        // Guard for current hunter and shed ID or return nil
        guard let currentHunter = HunterController.sharedInstance.currentHunter, shedID = shed.identifier else { return }
        
        // Create an index of removal to hold possible ID
        var indexOfRemoval: Int?
        
        
        // For
        for index in 0..<currentHunter.shedIDs.count {
            if currentHunter.shedIDs[index] == shedID {
                indexOfRemoval = index
            }
        }
        
        if let indexOfRemoval = indexOfRemoval {
            currentHunter.shedIDs.removeAtIndex(indexOfRemoval)
        }
        
        shed.delete()
    }
    
    // Modify post
    
    // MARK: - Fetch posts
    
    // fetch posts in 50 mile radius (observe)
    
    // fetch post based on identifier
    static func fetchShed(identifier: String, completion:(shed: Shed?) -> Void) {
        FirebaseController.dataAtEndPoint("/shed/\(identifier)") { (data) -> Void in
            guard let shedJson = data as? [String : AnyObject] else { completion(shed: nil) ; return }
            if let shed = Shed(json: shedJson, identifier: identifier) {
                completion(shed: shed)
            } else {
                completion(shed: nil)
            }
        }
    }
    
    // fetch posts based on users tracking list (observe)
    static func fetchSheds(completion:(shedIDs: [String]) -> Void) {
        
        var postsIDs = [String]()
        let group = dispatch_group_create()
        
        guard let currentHunter = HunterController.sharedInstance.currentHunter else { completion(shedIDs: []) ; return }
        for id in currentHunter.trackingIDs {
            dispatch_group_enter(group)
            FirebaseController.dataAtEndPoint("/hunter/\(id)", completion: { (data) -> Void in
                if let data = data, let postsDic = data["shedIDsKey"] as? [String : AnyObject] {
                    postsIDs.appendContentsOf(postsDic.keys)
                }
                dispatch_group_leave(group)
            })
        }
        
        dispatch_group_notify(group, dispatch_get_main_queue()) { () -> Void in
            completion(shedIDs: postsIDs)
        }
        
        
    }
    
    // Fetch Sheds for Timeline
    static func fetchShedsForTineline(completion:(sheds: [Shed]) -> Void) {
        
        var sheds = [String]()
        var shedsToDisplay = [Shed]()
        
        let groupOne = dispatch_group_create()
        
        dispatch_group_enter(groupOne)
        ShedController.fetchSheds { (shedIDs) -> Void in
            sheds = shedIDs
            dispatch_group_leave(groupOne)
        }
        
        
        dispatch_group_notify(groupOne, dispatch_get_main_queue()) { () -> Void in
            
            guard let currentHunter = HunterController.sharedInstance.currentHunter else { return }
            sheds.appendContentsOf(currentHunter.shedIDs)
            
            let groupTwo = dispatch_group_create()
            
            
            for index in 0..<sheds.count {
                dispatch_group_enter(groupTwo)
                if index <= 30 {
                    ShedController.fetchShed(sheds[index], completion: { (shed) -> Void in
                        if let shed = shed {
                            shedsToDisplay.append(shed)
                        }
                        dispatch_group_leave(groupTwo)
                    })
                } else {
                    dispatch_group_leave(groupTwo)
                }
            }
            
            dispatch_group_notify(groupTwo, dispatch_get_main_queue(), { () -> Void in
                completion(sheds: shedsToDisplay)
            })
        }
    }

    // MARK: - Comment Functionality
    
    // add comment
    static func addComment(imageIdentifier: String, hunterIdentifier: String, bodyText: String, var shed: Shed, completion: (comment: Comment?) -> Void) {
        
        var comment = Comment(bodyText: bodyText, imageIdentifier: imageIdentifier, hunterIdentifier: hunterIdentifier)
        comment.save()
        
        guard let commentID = comment.identifier else { completion(comment: nil) ; return }
        shed.messageIdentifiers.append(commentID)
        shed.save()
        
        completion(comment: comment)
        
    }
    
    // delete comment
    static func deleteComment(comment: Comment, shedID: String) {
        guard let commentID = comment.identifier else { return }
        fetchShed(shedID) { (shed) -> Void in
            guard let shed = shed else { return }
            
            var indexOfRemoval: Int?
            for index in 0..<shed.messageIdentifiers.count {
                if shed.messageIdentifiers[index] == commentID {
                    indexOfRemoval = index
                    return
                }
            }
            if let indexOfRemoval = indexOfRemoval {
                shed.messageIdentifiers.removeAtIndex(indexOfRemoval)
                comment.delete()
            }
        }
    }
    
    // retrieve comments
    static func fetchComments(commentIDs: [String], completion: (comments : [Comment]) -> Void) {
        var commentArray = [Comment]()
        for commentID in commentIDs {
            FirebaseController.dataAtEndPoint("/comment/\(commentID)", completion: { (data) -> Void in
                guard let commentJSON = data as? [String : AnyObject] else { completion(comments: []) ; return }
                if let comment = Comment(json: commentJSON, identifier: commentID) {
                    commentArray.append(comment)
                }
            })
        }
        
        completion(comments: commentArray)
    }
    
    // MARK: - Post specific alterations
    
    // Order posts based on time
    
    // Order comments based on time
    
}