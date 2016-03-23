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
    
    // Create new post
    
    static func createShed(bodyText: String, image: UIImage, hunterIdentifier: String, completion: (success: Bool) -> Void) {
        guard let currentHunter = HunterController.sharedInstance.currentHunter else { completion(success: false) ; return }
        PhotoController.sharedInstance.uploadImageToS3(image) { (url) -> () in
            if let url = url {
                var comment = Comment(bodyText: bodyText, imageIdentifier: url, hunterIdentifier: hunterIdentifier)
                comment.save()
                guard let commentID = comment.identifier else { completion(success: false) ; return }
                currentHunter.shedIDs.append(commentID)
                completion(success: true)
            } else {
                completion(success: false)
            }
        }
    }
    
    // Delete post
    static func deleteShed(shed : Shed) {
        guard let currentHunter = HunterController.sharedInstance.currentHunter, shedID = shed.identifier else { return }
        for index in 0..<currentHunter.shedIDs.count {
            if currentHunter.shedIDs[index] == shedID {
                currentHunter.shedIDs.removeAtIndex(index)
            }
        }
        shed.delete()
    }
    
    // Modify post
    
    // MARK: - Fetch posts
    
    // fetch posts in 50 mile radius (observe)
    
    // fetch post based on user identifier
    
    // fetch posts based on users tracking list (observe)
    static func fetchPosts(completion:(shedIDs: [String]) -> Void) {
        
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
            postsIDs.sortInPlace { $0 < $1 }
            
            completion(shedIDs: postsIDs)
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
    static func deleteComment(comment: Comment) {
        comment.delete()
    }
    
    // retrieve comments
    
    // MARK: - Post specific alterations
    
    // Order posts based on time
    
    // Order comments based on time
    
}