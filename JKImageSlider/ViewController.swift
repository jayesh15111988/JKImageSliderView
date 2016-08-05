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
        
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        self.view.addConstraint(NSLayoutConstraint(item: contentView, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: contentView, attribute: .Right, relatedBy: .Equal, toItem: self.view, attribute: .Right, multiplier: 1.0, constant: 0))
        
        let imageSwipeView = self.imageSwipeViewWithAttributes(true, mainTransitionType: kCATransitionPush, transitionDuration: 0.75, images: [UIImage(named: "girlRunning")!, UIImage(named: "changeColor")!, UIImage(named: "donald")!, UIImage(named: "cone")!])
        let imageSwipeView1 = self.imageSwipeViewWithAttributes(false, mainTransitionType: kCATransitionFade, transitionDuration: 0.5, images: [UIImage(named: "changeColor")!, UIImage(named: "donald")!, UIImage(named: "cone")!, UIImage(named: "girlRunning")!])
        let imageSwipeView2 = self.imageSwipeViewWithAttributes(true, mainTransitionType: kCATransitionMoveIn, transitionDuration: 2.0, images: [UIImage(named: "donald")!, UIImage(named: "changeColor")!, UIImage(named: "cone")!, UIImage(named: "girlRunning")!])
        let imageSwipeView3 = self.imageSwipeViewWithAttributes(false, mainTransitionType: kCATransitionReveal, transitionDuration: 0.1, images: [UIImage(named: "cone")!, UIImage(named: "changeColor")!, UIImage(named: "girlRunning")!, UIImage(named: "donald")!])
        
        
        contentView.addSubview(imageSwipeView)
        contentView.addSubview(imageSwipeView1)
        contentView.addSubview(imageSwipeView2)
        contentView.addSubview(imageSwipeView3)
        
        let views = ["imageSwipeView": imageSwipeView, "imageSwipeView1": imageSwipeView1, "imageSwipeView2": imageSwipeView2, "imageSwipeView3": imageSwipeView3, "contentView": contentView, "scrollView": scrollView]
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[scrollView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[scrollView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[contentView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[contentView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-5-[imageSwipeView]-5-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-5-[imageSwipeView1]-5-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-5-[imageSwipeView2]-5-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-5-[imageSwipeView3]-5-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-64-[imageSwipeView(200)]-[imageSwipeView1(200)]-[imageSwipeView2(200)]-[imageSwipeView3(200)]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
    
    }

    func imageSwipeViewWithAttributes(showBullerView: Bool, mainTransitionType: String, transitionDuration: CFTimeInterval, images: [UIImage]) -> JKImageSliderView {
        let imageSwipeView = JKImageSliderView(images: images, transitionType: mainTransitionType)
        imageSwipeView.translatesAutoresizingMaskIntoConstraints = false
        imageSwipeView.imageAnimationDuration = transitionDuration
        imageSwipeView.swipeEnabled = true
        imageSwipeView.showBulletView = showBullerView
        imageSwipeView.delegate = self
        imageSwipeView.layer.borderColor = UIColor.lightGrayColor().CGColor
        imageSwipeView.layer.borderWidth = 1.0
        return imageSwipeView
    }
    
    func indexChanged(to newIndex: Int) {
        print("Slider index changed to \(newIndex)")
    }


}

