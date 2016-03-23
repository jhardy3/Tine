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
        
        
        let image = UIImage(named: "Sheds")!
        ShedController.createShed(image, hunterIdentifier: HunterController.sharedInstance.currentHunter!.identifier!) { (success) -> Void in
            ShedController.fetchShedsForTineline { (sheds) -> Void in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.sheds = sheds
                    self.tableView.reloadData()
                })
            }
        }
        
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("shedCell", forIndexPath: indexPath) as! ShedTableViewCell
        
        PhotoController.fetchImageAtURL(sheds[indexPath.row].imageIdentifier) { (image) -> Void in
            cell.imageView?.image = image
        }
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sheds.count
    }
}
