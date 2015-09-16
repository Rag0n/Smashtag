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
        
        if tweet?.media.count > 0 {
            let imageMentionValues = tweet?.media.map { MentionValue.imageMention($0.url, $0.aspectRatio) }
            let newMention = Mention(name: Constants.imagesName, value: imageMentionValues!)
            self.mentions.append(newMention)
        }
        
        addTextMention(tweet!.userMentions, mentionName: Constants.usersName)
        addTextMention(tweet!.urls, mentionName: Constants.urlsName)
        addTextMention(tweet!.hashtags, mentionName: Constants.hashtagsName)

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
//        tableView.estimatedRowHeight = tableView.rowHeight
//        tableView.rowHeight = UITableViewAutomaticDimension
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
                return cell
            case .imageMention(let imageURL, let aspectRatio):
                let cell = tableView.dequeueReusableCellWithIdentifier(Constants.imageMentionCellReuseIdentifier, forIndexPath: indexPath) as! MentionImageTableViewCell
                cell.imageURL = imageURL
                return cell
        }

    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let mention = mentions[indexPath.section].value[indexPath.row]
        switch mention {
        case .textMention(let mentionName):
            return UITableViewAutomaticDimension
        case .imageMention(let imageURL, let aspectRatio):
            var test = tableView.bounds.size.width / CGFloat(aspectRatio)
            return tableView.frame.size.width / CGFloat(aspectRatio)
        }
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200.0
    }
    
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       return mentions[section].name
    }



}
