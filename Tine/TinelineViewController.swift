//
//  TinelineViewController.swift
//  Tine
//
//  Created by Jake Hardy on 3/22/16.
//  Copyright © 2016 NSDesert. All rights reserved.
//

import UIKit

class TinelineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // shedCell
    
    var sheds = [Shed]()
    
    @IBOutlet weak var segmentedController: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ShedController.fetchShedsForTineline { (sheds) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.sheds = sheds.sort { $0.0.identifier > $0.1.identifier }
                self.tableView.reloadData()
            })
        }
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refresh:", forControlEvents: .ValueChanged)
        tableView.addSubview(refreshControl)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("shedCell", forIndexPath: indexPath) as! ShedTableViewCell
        
        cell.updateWith(sheds[indexPath.row])
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sheds.count
    }
    
    func refresh(refreshControl: UIRefreshControl) {
        ShedController.fetchShedsForTineline { (sheds) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.sheds = sheds.sort { $0.0.identifier > $0.1.identifier }
                self.tableView.reloadData()
            })
        }
        refreshControl.endRefreshing()
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toProfile" {
            let destinationView = segue.destinationViewController as? ProfileViewController
            if let button = sender as? UIButton,
                let view = button.superview,
                let cell = view.superview as? ShedTableViewCell {
                    guard let indexPath = tableView.indexPathForCell(cell)  else { return }
                    let identifier = self.sheds[indexPath.row].hunterIdentifier
                    destinationView?.updateWithIdentifier(identifier)
            }
        }
    }
}
