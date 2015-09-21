//
//  HistoryTableViewController.swift
//  Smashtag
//
//  Created by Александр on 21.09.15.
//  Copyright © 2015 Stanford University. All rights reserved.
//

import UIKit

class HistoryTableViewController: UITableViewController {
    
    private var history = HistorySearch()
    
    // MARK: - View Controller Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.searchHistory.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("historySearch", forIndexPath: indexPath)
        let searchText = history.searchHistory[indexPath.row]
        cell.textLabel?.text = searchText
        return cell
    }


     // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "show tweet from history" {
            if let ttvc = segue.destinationViewController as? TweetTableViewController {
                if let selectedIndex = tableView.indexPathForCell(sender as! UITableViewCell) {
                    ttvc.searchText = history.searchHistory[selectedIndex.row]
                }
            }
        }
    }


}
