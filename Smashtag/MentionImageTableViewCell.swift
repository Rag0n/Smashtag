//
//  MentionImageTableViewCell.swift
//  Smashtag
//
//  Created by Александр on 15.09.15.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import UIKit

class MentionImageTableViewCell: UITableViewCell {
    @IBOutlet weak var mentionImage: UIImageView!{
        didSet {
            self.mentionImage.contentMode = UIViewContentMode.ScaleAspectFill
        }
    }
    
    //MARK: - Public API
    var imageURL: NSURL? {
        didSet {
            fetchImage()
        }
    }
    
    //MARK: - Private API
    private func fetchImage() {
        if let url = imageURL {
            let qos = Int(QOS_CLASS_USER_INITIATED.rawValue)
            dispatch_async(dispatch_get_global_queue(qos, 0)) { () -> Void in
                let imageData = NSData(contentsOfURL: url)
                dispatch_async(dispatch_get_main_queue()) {
                    if url == self.imageURL {
                        if imageData != nil {
                            self.mentionImage.image = UIImage(data: imageData!)
                        } else {
                            self.mentionImage = nil
                        }
                    }
                }
            }
        }
    }
}
