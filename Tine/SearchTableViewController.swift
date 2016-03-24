//
//  SearchTableViewController.swift
//  Tine
//
//  Created by Jake Hardy on 3/21/16.
//  Copyright © 2016 NSDesert. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, UISearchResultsUpdating {
    
    enum ViewMode: Int {
        case Hunters = 0
        case AddHunter = 1
        
        func hunters(completion:(hunters: [Hunter]) -> Void) {
            
            switch self {
                
            case Hunters:
                guard let tracking = HunterController.sharedInstance.currentHunter?.trackingIDs else { completion(hunters: []) ; return }
                HunterController.fetchHuntersWithIdentifierArray(tracking, completion: { (hunters) -> Void in
                    completion(hunters: hunters)
                })
                
            case AddHunter:
                HunterController.fetchAllHunters({ (var hunters) -> Void in
                    var indexOfRemoval: Int?
                    for index in 0..<hunters.count {
                        if HunterController.sharedInstance.currentHunter!.identifier! == hunters[index].identifier! {
                            indexOfRemoval = index
                        }
                    }
                    if let indexOfRemoval = indexOfRemoval {
                        hunters.removeAtIndex(indexOfRemoval)
                    }

                    completion(hunters: hunters)
                })
            }
        }
    }
    
    
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    var searchController: UISearchController!
    var usersDataSource = [Hunter]()
    
    var mode: ViewMode {
        get {
            return ViewMode(rawValue: segmentedControl.selectedSegmentIndex)!
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        setUpSearchController()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return usersDataSource.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("searchCell", forIndexPath: indexPath)
        
        cell.textLabel?.text = usersDataSource[indexPath.row].username
        
        return cell
    }
    
    
    func updateViewBasedOnMode() {
        mode.hunters { (hunters) -> Void in
            self.usersDataSource = hunters
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
            })
        }
    }
    
    func setUpSearchController() {
        
        let resultsController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("UserSearchResultsTableViewController")
        
        searchController = UISearchController(searchResultsController: resultsController)
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        searchController.hidesNavigationBarDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        
        definesPresentationContext = true
        
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        if let searchTerm = searchController.searchBar.text?.lowercaseString,
            let resultsViewController = searchController.searchResultsController as? SearchResultsTableViewController {
                
                resultsViewController.usersResultsDataSource = usersDataSource.filter {$0.username.lowercaseString.containsString(searchTerm)}
                resultsViewController.tableView.reloadData()
        }
        
    }
    
    @IBAction func segmentedControllerChanged(sender: UISegmentedControl) {
        updateViewBasedOnMode()
    }
    
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
    }
    */
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toHunter" {
            guard let cell = sender as? UITableViewCell else { return }
            
            if let indexPath = tableView.indexPathForCell(cell) {
                
                let hunter = usersDataSource[indexPath.row]
                
                let destinationViewController = segue.destinationViewController as? ProfileViewController
                destinationViewController?.hunter = hunter
                
            } else if let indexPath = (searchController.searchResultsController as? SearchResultsTableViewController)?.tableView.indexPathForCell(cell) {
                
                let hunter = (searchController.searchResultsController as! SearchResultsTableViewController).usersResultsDataSource[indexPath.row]
                
                let destinationViewController = segue.destinationViewController as? ProfileViewController
                destinationViewController?.hunter = hunter
            }
        }
    }
    
    
}
