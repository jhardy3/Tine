//
//  TinelineViewController.swift
//  Tine
//
//  Created by Jake Hardy on 3/22/16.
//  Copyright © 2016 NSDesert. All rights reserved.
//

import UIKit

class TinelineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Properties
    
    // Create a sheds array to hold sheds being displayed by tableview cells
    var sheds = [Shed]()
    
    // MARK: - IBOutlet Properties
    
    // Segmented Controller that swaps between hunter tineline and proximity tineline
    @IBOutlet weak var segmentedController: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Class Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Fetch all sheds for initial tineline preview ( eventually this will be dependent upon segmented control && refined )
        ShedController.fetchShedsForTineline { (sheds) -> Void in
            
            // Call main queue to refresh view; reload tableview data accordingly
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.sheds = sheds.sort { $0.0.identifier > $0.1.identifier }
                self.tableView.reloadData()
            })
        }
        
        // Adds a refreshController. Grabs new Tineline information when present
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refresh:", forControlEvents: .ValueChanged)
        tableView.addSubview(refreshControl)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("shedCell", forIndexPath: indexPath) as! ShedTableViewCell

        cell.updateWith(sheds[indexPath.row])
        cell.delegate = self
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sheds.count
    }
    
    // MARK: - Data Update Functions
    
    func refresh(refreshControl: UIRefreshControl) {
        
        // When refreshed, completes fetch sheds again and reloads tableview in main thread
        ShedController.fetchShedsForTineline { (sheds) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.sheds = sheds.sort { $0.0.identifier > $0.1.identifier }
                self.tableView.reloadData()
            })
        }
        
        // End refresh animation
        refreshControl.endRefreshing()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toProfile" {
            
            // Grab destination view controller
            let destinationView = segue.destinationViewController as? ProfileViewController
            
            // Button is inside of tableView cell. It is the sender in this case so cast it as UIButton
            if let button = sender as? UIButton,
                
                // button.superview returns the ShedTableViewCell view instance (this is what we want, it will grab the indexPath)
                let view = button.superview,
                
                // the superview of the view instance is the actual shedTableViewCell
                let cell = view.superview as? ShedTableViewCell {
                    
                    // If all succeeds grab index path from tableview using cell or return
                    guard let indexPath = tableView.indexPathForCell(cell)  else { return }
                    
                    // grab identifier from sheds at indexpath and update destinationView with identifier
                    let identifier = self.sheds[indexPath.row].hunterIdentifier
                    destinationView?.updateWithIdentifier(identifier)
            }
        }
    }
}
