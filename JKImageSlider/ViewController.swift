//
//  ViewController.swift
//  JKImageSlider
//
//  Created by Jayesh Kawli Backup on 7/30/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import UIKit

class ViewController: UIViewController, JKSliderViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageSwipeView = JKImageSliderView(images: [UIImage(named: "girlRunning")!, UIImage(named: "changeColor")!, UIImage(named: "donald")!, UIImage(named: "cone")!], transitionType: kCATransitionPush)
        imageSwipeView.translatesAutoresizingMaskIntoConstraints = false
        imageSwipeView.imageAnimationDuration = 0.5
        imageSwipeView.swipeEnabled = true
        imageSwipeView.delegate = self        
        imageSwipeView.layer.borderColor = UIColor.lightGrayColor().CGColor
        imageSwipeView.layer.borderWidth = 1.0
        self.view.addSubview(imageSwipeView)
        let views = ["imageSwipeView": imageSwipeView]
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-5-[imageSwipeView]-5-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-64-[imageSwipeView(200)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
    
    }

    func indexChanged(to newIndex: Int) {
        
    }


}

