//
//  HistoryTableViewController.swift
//  Smashtag
//
//  Created by Александр on 21.09.15.
//  Copyright © 2015 Stanford University. All rights reserved.
//

import UIKit

class HistoryTableViewController: UITableViewController {
    
    private var searchHistory = [String]()
    
    private func loadHistory() {
        let defaults = NSUserDefaults.standardUserDefaults()
        if let historyArray = defaults.objectForKey("searchHistory") as? [String] {
            for searchText in historyArray {
                searchHistory.append(searchText)
            }
        }
    }
    
    // MARK: - View Controller Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        loadHistory()
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchHistory.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
        let searchText = searchHistory[indexPath.row]
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
