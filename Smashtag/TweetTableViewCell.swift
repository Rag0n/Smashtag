//
//  TweetTableViewCell.swift
//  Smashtag
//
//  Created by CS193p Instructor.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell
{
    var tweet: Tweet? {
        didSet {
            updateUI()
        }
    }
    
    struct Constants {
        static let userNameColor = UIColor.greenColor()
        static let hashtagColor = UIColor.orangeColor()
        static let urlColor = UIColor.blueColor()
    }
    
    
    @IBOutlet weak var tweetProfileImageView: UIImageView!
    @IBOutlet weak var tweetScreenNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var tweetCreatedLabel: UILabel!
    
    func updateUI() {
        // reset any existing tweet information
        tweetTextLabel?.attributedText = nil
        tweetScreenNameLabel?.text = nil
        tweetProfileImageView?.image = nil
        tweetCreatedLabel?.text = nil
        
        // load new information from our tweet (if any)
        if let tweet = self.tweet
        {
            tweetTextLabel?.text = tweet.text
            if tweetTextLabel?.text != nil  {
                for _ in tweet.media {
                    tweetTextLabel.text! += " 📷"
                }
                
                let attributedString = NSMutableAttributedString(string: tweetTextLabel!.text!)
                configureAttributedString(attributedString, withKeywords: tweet.hashtags, color: Constants.hashtagColor)
                configureAttributedString(attributedString, withKeywords: tweet.userMentions, color: Constants.userNameColor)
                configureAttributedString(attributedString, withKeywords: tweet.urls, color: Constants.urlColor)

                tweetTextLabel.attributedText = attributedString
            }

            
            
            tweetScreenNameLabel?.text = "\(tweet.user)" // tweet.user.description
            
            if let profileImageURL = tweet.user.profileImageURL {
                if let imageData = NSData(contentsOfURL: profileImageURL) { // blocks main thread!
                    tweetProfileImageView?.image = UIImage(data: imageData)
                }
            }
            
            let formatter = NSDateFormatter()
            if NSDate().timeIntervalSinceDate(tweet.created) > 24*60*60 {
                formatter.dateStyle = NSDateFormatterStyle.ShortStyle
            } else {
                formatter.timeStyle = NSDateFormatterStyle.ShortStyle
            }
            tweetCreatedLabel?.text = formatter.stringFromDate(tweet.created)
        }

    }
    
    private func configureAttributedString(attributedString: NSMutableAttributedString, withKeywords: [Tweet.IndexedKeyword], color: UIColor) {
        for keyword in withKeywords {
            attributedString.addAttribute(NSForegroundColorAttributeName, value: color, range: keyword.nsrange)
        }
    }
}
