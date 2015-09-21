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
    
    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.searchHistory.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
        let searchText = history.searchHistory[indexPath.row]
        cell.textLabel?.text = searchText
        return cell
    }



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
