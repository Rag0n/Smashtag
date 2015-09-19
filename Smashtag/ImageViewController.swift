//
//  ImageViewController.swift
//  Smashtag
//
//  Created by Александр on 19.09.15.
//  Copyright © 2015 Stanford University. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {

    //MARK: - Public API
    var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
//            scrollView.contentMode = UIViewContentMode.ScaleAspectFit
            scrollView.delegate = self
            scrollView.contentSize = imageView.frame.size
        }
    }
    
    //MARK: - Private API
    private var imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.addSubview(imageView)
    }

}
