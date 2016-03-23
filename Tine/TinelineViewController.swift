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
    
    static let sharedInstance = TinelineViewController()
    
    var sheds = [Shed]()
    
    @IBOutlet weak var segmentedController: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        ShedController.fetchShedsForTineline { (sheds) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.sheds = sheds
                self.tableView.reloadData()
            })
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
}
