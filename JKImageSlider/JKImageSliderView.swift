//
//  JKImageSliderView.swift
//  JKImageSlider
//
//  Created by Jayesh Kawli Backup on 7/31/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import UIKit
import SDWebImage

enum JKImageSliderViewImageType {
    case ImageTypeURL
    case ImageTypeImage
}


class JKImageSliderView: UIView {
    
    let images: [UIImage]
    let imageURLs: [NSURL]
    var leftSwipeGestureRecognizer: UISwipeGestureRecognizer?
    var rightSwipeGestureRecognizer: UISwipeGestureRecognizer?
    var currentImageIndex: Int
    var swipeViewTransition: CATransition
    var swipeImageView: UIImageView
    var imagesCount: Int
    var imageType: JKImageSliderViewImageType
    var placeHolder: UIImage
    var imageAnimationDuration: CFTimeInterval {
        didSet {
            swipeViewTransition.duration = imageAnimationDuration
        }
    }
    var bulletView: JKBulletView?
    
    var swipeEnabled: Bool {
        didSet {
            if swipeEnabled == true {
                if let leftSwipe = leftSwipeGestureRecognizer, rightSwipe = rightSwipeGestureRecognizer {
                    self.addGestureRecognizer(leftSwipe)
                    self.addGestureRecognizer(rightSwipe)
                }
            } else {
                if let leftSwipe = leftSwipeGestureRecognizer, rightSwipe = rightSwipeGestureRecognizer {
                    self.removeGestureRecognizer(leftSwipe)
                    self.removeGestureRecognizer(rightSwipe)
                }
            }
        }
    }
    
    init (images: [UIImage], transitionType: String = kCATransitionFade, placeholderImage: UIImage? = nil, showBullets: Bool = false) {
        self.images = images
        self.imageURLs = []
        self.imagesCount = self.images.count
        self.swipeEnabled = false
        currentImageIndex = 0
        imageAnimationDuration = 0.75
        swipeViewTransition = CATransition()
        swipeViewTransition.type = transitionType
        imageType = .ImageTypeImage
        placeHolder = placeholderImage ?? UIImage()
        swipeImageView = UIImageView()
        super.init(frame: CGRect.zero)
        self.initializeGestureRecognizers()
        self.setupImageViews()
    }
    
    init (imageURLs: [NSURL], transitionType: String = kCATransitionFade, placeholderImage: UIImage? = nil, showBullets: Bool = false) {
        self.images = []
        self.imageURLs = imageURLs
        self.imagesCount = self.imageURLs.count
        self.swipeEnabled = false
        currentImageIndex = 0
        imageAnimationDuration = 0.75
        swipeViewTransition = CATransition()
        swipeViewTransition.type = transitionType
        imageType = .ImageTypeURL
        swipeImageView = UIImageView()
        placeHolder = placeholderImage ?? UIImage()
        super.init(frame: CGRect.zero)
        self.initializeGestureRecognizers()
        self.setupImageViews()
    }
    
    func initializeGestureRecognizers() {
        // Do not add swipe gesture recognizer if image count is less than 2.
        if self.imageCountGreaterThanThreshold() == true {
            self.leftSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft))
            self.leftSwipeGestureRecognizer?.direction = .Right
            self.rightSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeRight))
            self.rightSwipeGestureRecognizer?.direction = .Left
        }
    }
    
    func setupImageViews() {
        swipeViewTransition.duration = imageAnimationDuration
        swipeImageView.translatesAutoresizingMaskIntoConstraints = false
        swipeImageView.contentMode = .ScaleAspectFit
        self.addSubview(swipeImageView)
        let views = ["swipeImageView": swipeImageView]
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[swipeImageView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[swipeImageView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        
        if imageCountGreaterThanThreshold() == true {
            let leftArrowButton = UIButton()
            let rightArrowButton = UIButton()
            leftArrowButton.translatesAutoresizingMaskIntoConstraints = false
            rightArrowButton.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(leftArrowButton)
            self.addSubview(rightArrowButton)
            leftArrowButton.setImage(UIImage(named: "left_arrow"), forState: .Normal)
            rightArrowButton.setImage(UIImage(named: "right_arrow"), forState: .Normal)
            leftArrowButton.addTarget(self, action: #selector(swipeLeft), forControlEvents: .TouchUpInside)
            rightArrowButton.addTarget(self, action: #selector(swipeRight), forControlEvents: .TouchUpInside)
            
            let arrowViews = ["leftArrowButton": leftArrowButton, "rightArrowButton": rightArrowButton]
            
            self.addConstraint(NSLayoutConstraint(item: leftArrowButton, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1.0, constant: 0))
            self.addConstraint(NSLayoutConstraint(item: rightArrowButton, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1.0, constant: 0))
            self.addConstraint(NSLayoutConstraint(item: leftArrowButton, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 30))
            self.addConstraint(NSLayoutConstraint(item: rightArrowButton, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 30))
            self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[leftArrowButton(30)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: arrowViews))
            self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[rightArrowButton(30)]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: arrowViews))
            
            bulletView = JKBulletView(numberOfBullets: imagesCount)
            if let bulletV = bulletView {
                bulletV.animationDuration = self.imageAnimationDuration
                bulletV.translatesAutoresizingMaskIntoConstraints = false
                self.addSubview(bulletV)
                let bulletViews = ["bulletView": bulletV]
                self.addConstraint(NSLayoutConstraint(item: bulletV, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1.0, constant: 0))
                self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[bulletView(30)]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: bulletViews))
            }
        }
        self.updateImage()
    }
    
    func imageCountGreaterThanThreshold() -> Bool {
        return self.images.count > 1 || self.imageURLs.count > 1
    }
    
    @objc func swipeLeft() {
        self.swipeViewTransition.subtype = kCATransitionFromLeft
        self.swipeImageView.layer.addAnimation(self.swipeViewTransition, forKey: kCATransition)
        currentImageIndex = currentImageIndex - 1
        currentImageIndex = ((currentImageIndex % imagesCount) + imagesCount) % imagesCount
        self.updateImage()
        self.bulletView?.moveToIndex(currentImageIndex)
    }
    
    @objc func swipeRight() {
        self.swipeViewTransition.subtype = kCATransitionFromRight
        self.swipeImageView.layer.addAnimation(self.swipeViewTransition, forKey: kCATransition)
        currentImageIndex = currentImageIndex + 1
        currentImageIndex = ((currentImageIndex % imagesCount) + imagesCount) % imagesCount
        self.updateImage()
        self.bulletView?.moveToIndex(currentImageIndex)
    }
    
    func updateImage() {
        if imageType == .ImageTypeURL {
            swipeImageView.sd_setImageWithURL(imageURLs[currentImageIndex], placeholderImage: placeHolder, options: .HighPriority)
        } else {
            swipeImageView.image = images[currentImageIndex]
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
