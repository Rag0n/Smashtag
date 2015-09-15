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
//            mentions.removeAll()
            updateUI()
        }
    }
    
    func updateUI() {
        
        addTextMention(tweet!.hashtags, mentionName: Constants.hashtagsName)
        addTextMention(tweet!.urls, mentionName: Constants.urlsName)
        addTextMention(tweet!.userMentions, mentionName: Constants.usersName)

        if tweet?.media.count > 0 {
            let imageMentionValues = tweet?.media.map { MentionValue.imageMention($0.url, $0.aspectRatio) }
            let newMention = Mention(name: Constants.imagesName, value: imageMentionValues!)
            self.mentions.append(newMention)
        }
    }
    

    // MARK: - Private API
    private var mentions = [Mention]()
    
    private struct Mention {
        var name: String
        var value: [MentionValue]
    }
    
    private enum MentionValue {
        case textMention(String)
        case imageMention(NSURL, Double)
        
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
        static let textMentionCellReuseIdentifier = "Mentions"
        static let imageMentionCellReuseIdentifier = "Mention image"
    }
    
    private func addTextMention(indexedKeywords: [Tweet.IndexedKeyword], mentionName: String) {
        if indexedKeywords.count <= 0 {
            return
        }
        let keywordsArray = indexedKeywords.map { $0.keyword } // array of keywords(hashtags, urls, users)
        var mentionValues = [MentionValue]()
        
        for mention in keywordsArray {
            mentionValues.append(MentionValue.textMention(mention))
        }
        
        let newMention = Mention(name: mentionName, value: mentionValues)
        self.mentions.append(newMention)
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
        return mentions.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mentions[section].value.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let mention = mentions[indexPath.section].value[indexPath.row]
        switch mention {
            case .textMention(let mentionName):
                let cell = tableView.dequeueReusableCellWithIdentifier(Constants.textMentionCellReuseIdentifier, forIndexPath: indexPath) as! UITableViewCell
                cell.textLabel?.text = mentionName
            case .imageMention(let _, let _):
                let cell = tableView.dequeueReusableCellWithIdentifier(Constants.imageMentionCellReuseIdentifier, forIndexPath: indexPath) as! MentionImageTableViewCell
//                cell.mentionImage.image = image
        }
        let cell = tableView.dequeueReusableCellWithIdentifier(Constants.textMentionCellReuseIdentifier, forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel?.text = mention.get()
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       return mentions[section].name
    }



}
