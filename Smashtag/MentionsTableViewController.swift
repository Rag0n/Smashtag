//
//  MentionsTableViewController.swift
//  Smashtag
//
//  Created by Александр on 15.09.15.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import UIKit

class MentionsTableViewController: UITableViewController {
    
    // MARK: - Public API
    var tweet: Tweet? {
        didSet {
            if tweet?.hashtags.count > 0 {
                let hashtags = tweet!.hashtags.map { $0.keyword }
                var mentionValues = [MentionValue]()
                
                for hashtag in hashtags {
                    mentionValues.append(MentionValue.textMention(hashtag))
                }
                var hashtagsMention = Mention(name: Constants.hashtagsName, value: mentionValues)
            }
        }
    }
    
    struct Constants {
        static let hashtagsName = "hashtags"
        static let urlsName = "urls"
        static let usersName = "users"
        static let imagesName = "images"
    }
    
    // MARK: - Private Structure
    private var mentions = [Mention]()
    
    private struct Mention {
        var name: String
        var value: [MentionValue]
    }
    
    private enum MentionValue {
        case textMention(String)
        case imageMention(UIImage)
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 0
    }



}
