//
//  ViewController.swift
//  JKImageSlider
//
//  Created by Jayesh Kawli Backup on 7/30/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageSwipeView = JKImageSliderView(images: [UIImage(named: "girlRunning")!, UIImage(named: "changeColor")!, UIImage(named: "donald")!, UIImage(named: "cone")!], transitionType: kCATransitionPush)
        imageSwipeView.translatesAutoresizingMaskIntoConstraints = false
        imageSwipeView.imageAnimationDuration = 0.5
        imageSwipeView.swipeEnabled = true
        self.view.addSubview(imageSwipeView)
        let views = ["imageSwipeView": imageSwipeView]
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[imageSwipeView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-100-[imageSwipeView(200)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

