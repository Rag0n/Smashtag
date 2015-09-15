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
            updateUI()
        }
    }
    
    func updateUI() {
        if tweet?.hashtags.count > 0 {
            let hashtags = tweet!.hashtags.map { $0.keyword }
            var mentionValues = [MentionValue]()
            
            for hashtag in hashtags {
                mentionValues.append(MentionValue.textMention(hashtag))
            }
            var hashtagsMention = Mention(name: Constants.hashtagsName, value: mentionValues)
            mentions.append(hashtagsMention)
        }

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
        
        func get() -> String {
            switch self {
            case .textMention(let name): return name
            case .imageMention(let imageName): return "\(imageName)"
            }
        }
    }
    
    private struct Constants {
        static let hashtagsName = "hashtags"
        static let urlsName = "urls"
        static let usersName = "users"
        static let imagesName = "images"
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return mentions.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mentions[section].value.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        let mention = mentions[indexPath.section].value[indexPath.row]
        cell.textLabel?.text = mention.get()
        return cell
    }



}
