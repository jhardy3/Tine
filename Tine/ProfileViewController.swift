//
//  ProfileViewController.swift
//  Tine
//
//  Created by Jake Hardy on 3/21/16.
//  Copyright © 2016 NSDesert. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    var hunter: Hunter?
    
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    var isFollowing: Bool {
        get {
            if followButton.titleLabel?.text == "track" {
                return false
            } else {
                return true
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let hunterTrackIDs = HunterController.sharedInstance.currentHunter?.trackingIDs, let hunterID = hunter?.identifier {
            if hunterTrackIDs.contains(hunterID) {
                followButton.setTitle("Untrack", forState: .Normal)
            } else {
                followButton.setTitle("track", forState: .Normal)
            }
            if HunterController.sharedInstance.currentHunter?.identifier == hunterID {
                followButton.hidden = true
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("shedCell", forIndexPath: indexPath)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    @IBAction func followButtonTapped(sender: UIButton) {
        guard let hunter = self.hunter else { return }
        if isFollowing {
            HunterController.hunterUntrackHunter(hunter)
            followButton.setTitle("Track", forState: .Normal)
        } else {
            HunterController.hunterTrackHunter(hunter)
            followButton.setTitle("Untrack", forState: .Normal)
        }
    }
    
    func updateWithIdentifier(identifier: String) {
        HunterController.fetchHunterForIdentifier(identifier) { (hunter) -> Void in
            if let hunter = hunter {
                self.hunter = hunter
                print("Hunter Received")
            }
            
        }
    }
    
}
