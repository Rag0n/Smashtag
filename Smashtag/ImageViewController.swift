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
            imageView.contentMode = UIViewContentMode.ScaleAspectFit
            imageView.sizeToFit()
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.contentSize = imageView.bounds.size
            // required for zooming
            scrollView.delegate = self
            scrollView.maximumZoomScale = 3
            scrollView.minimumZoomScale = 1
        }
    }
    
    //MARK: - Private API
    private var imageView = UIImageView()
    private var zoomed = true
    
    func autozoom() {
        if(!zoomed) {
            return
        }
        let widthRatio = scrollView.bounds.size.width / imageView.bounds.size.width
        let heightRatio = scrollView.bounds.size.height / imageView.bounds.size.height
        scrollView.zoomScale = (widthRatio > heightRatio) ? widthRatio : heightRatio
    }
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.addSubview(imageView)
        autozoom()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        autozoom()
    }
    
    // MARK: - UIScrollViewDelegate
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewWillBeginZooming(scrollView: UIScrollView, withView view: UIView?) {
        zoomed = false
    }
    

}
