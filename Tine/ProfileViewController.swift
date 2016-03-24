//
//  ProfileViewController.swift
//  Tine
//
//  Created by Jake Hardy on 3/21/16.
//  Copyright © 2016 NSDesert. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: - Class Properties
    
    // Hunter for profile View
    var hunter: Hunter?
    var sheds =  [Shed]()
    
    // MARK: - IBOutlet Properties
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // is Following Bool checks for following status based on button title text
    var isFollowing: Bool {
        get {
            if followButton.titleLabel?.text == "track" {
                return false
            } else {
                return true
            }
        }
    }
    
    // MARK: - Class Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("shedCell", forIndexPath: indexPath) as? ImageCollectionViewCell {
            let shed = sheds[indexPath.row]
            cell.updateWith(shed)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("shedCell", forIndexPath: indexPath)
            return cell
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sheds.count
    }
    
    // MARK: - IBAction Functions
    
    // Follows or unfollows a hunter depending on current follow status
    @IBAction func followButtonTapped(sender: UIButton) {
        
        // Guard for hunter
        guard let hunter = self.hunter else { return }
        
        // Check if hunter is following ; if is following unfollow and set title Vice versa otherwise
        if isFollowing {
            HunterController.hunterUntrackHunter(hunter)
            followButton.setTitle("Track", forState: .Normal)
        } else {
            HunterController.hunterTrackHunter(hunter)
            followButton.setTitle("Untrack", forState: .Normal)
        }
    }
    
    
    // Update with identifier to retrieve hunter
    func updateWithIdentifier(identifier: String) {
        
        let groupNew = dispatch_group_create()
        
        dispatch_group_enter(groupNew)
        // Grab hunter from firebase
        HunterController.fetchHunterForIdentifier(identifier) { (hunter) -> Void in
            
            // If hunter is prevalent set hunter property to retrieved hunter
            if let hunter = hunter {
                self.hunter = hunter
                print("Hunter Received")
            }
            dispatch_group_leave(groupNew)
            
        }
        
        
        dispatch_group_notify(groupNew, dispatch_get_main_queue()) { () -> Void in
            // Checks current hunter for profile hunter ID. If exists sets title to untrack otherwise sets to track
            if let hunterTrackIDs = HunterController.sharedInstance.currentHunter?.trackingIDs, let hunterID = self.hunter?.identifier {
                if hunterTrackIDs.contains(hunterID) {
                    self.followButton.setTitle("Untrack", forState: .Normal)
                } else {
                    self.followButton.setTitle("track", forState: .Normal)
                }
                
                // If viewing own profile, sets follow button to hidden
                if HunterController.sharedInstance.currentHunter?.identifier == hunterID {
                    self.followButton.hidden = true
                }
            }
            
            // Create group to keep async calls in order
            let group = dispatch_group_create()
            
            // check for hunter
            if let hunter = self.hunter {
                
                // If hunter exists grab all shed IDs and fetch shed ; enter dispatch group
                for id in hunter.shedIDs {
                    dispatch_group_enter(group)
                    
                    // Grab shed from firebase
                    ShedController.fetchShed(id, completion: { (shed) -> Void in
                        
                        // if shed is present append to sheds array
                        if let shed = shed {
                            self.sheds.append(shed)
                        }
                        
                        // notify dispatch call has ended
                        dispatch_group_leave(group)
                    })
                }
            }
            
            // Once async calls finish reload data
            dispatch_group_notify(group, dispatch_get_main_queue()) { () -> Void in
                self.collectionView.reloadData()
            }
        }
    }
    
}
