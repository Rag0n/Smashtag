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
        static let SearchMentionSegueIdentifier = "Search mention"
        static let ShowImageSegueIdentifier = "Show image"
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
                let cell = tableView.dequeueReusableCellWithIdentifier(Constants.textMentionCellReuseIdentifier, forIndexPath: indexPath) 
                cell.textLabel?.text = mentionName
                return cell
            case .imageMention(let imageURL, _):
                let cell = tableView.dequeueReusableCellWithIdentifier(Constants.imageMentionCellReuseIdentifier, forIndexPath: indexPath) as! MentionImageTableViewCell
                cell.imageURL = imageURL
                return cell
        }

    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let mention = mentions[indexPath.section].value[indexPath.row]
        switch mention {
        case .textMention(_):
            return UITableViewAutomaticDimension
        case .imageMention(_, let aspectRatio):
            return tableView.frame.size.width / CGFloat(aspectRatio)
        }
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200.0
    }
    
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       return mentions[section].name
    }

    //MARK: - Navigation
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if identifier == Constants.SearchMentionSegueIdentifier {
            if let cell = sender as? UITableViewCell {
                let senderText = cell.textLabel?.text
                if senderText?.hasPrefix("http://") == true {
                    if let url = NSURL(string: senderText!) {
                        UIApplication.sharedApplication().openURL(url)
                        return false
                    }
                }
            }
        }
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case Constants.SearchMentionSegueIdentifier:
                if let ttvc = segue.destinationViewController as? TweetTableViewController {
                    if let selectedCell = sender as? UITableViewCell {
                        let searchText = selectedCell.textLabel?.text
                        ttvc.searchText = searchText
                    }
                }
            case Constants.ShowImageSegueIdentifier:
                if let ivc = segue.destinationViewController as? ImageViewController {
                    if let selectedImage = sender as? MentionImageTableViewCell {
                        ivc.image = selectedImage.mentionImage.image
                    }
                }
            default: break
            }
        }
    }
}
