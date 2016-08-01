//
//  JKBulletView.swift
//  JKImageSlider
//
//  Created by Jayesh Kawli Backup on 7/31/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import UIKit

class JKBulletView: UIView {

    let numberOfBullets: Int
    var highlightedBulletImageView: UIImageView
    var unhighlightedBulletViewsCollection: [UIImageView]
    var highlightedBulletHorizontalConstraint: NSLayoutConstraint?
    var animationDuration: CFTimeInterval = 0.75;
    
    init(numberOfBullets: Int) {
        self.numberOfBullets = numberOfBullets
        self.highlightedBulletImageView = UIImageView(image: UIImage(named: "bullet_black"))
        self.unhighlightedBulletViewsCollection = []
        super.init(frame: CGRect.zero)
        
        var previousBulletImageView: UIImageView?
        
        for i in 0..<numberOfBullets {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.image = UIImage(named: "bullet_grey")
            self.addSubview(imageView)
            if i == 0 {
                self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[imageView(30)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["imageView": imageView]))
            } else if i == numberOfBullets - 1 {
                if let previousImageView = previousBulletImageView {
                    self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[previousBulletImageView]-[imageView(30)]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["imageView": imageView, "previousBulletImageView": previousImageView]))
                }
            } else {
                if let previousImageView = previousBulletImageView {
                    self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[previousBulletImageView]-[imageView(30)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["imageView": imageView, "previousBulletImageView": previousImageView]))
                }
            }
            self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[imageView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["imageView": imageView]))
            self.unhighlightedBulletViewsCollection.append(imageView)
            previousBulletImageView = imageView
        }
        highlightedBulletImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(highlightedBulletImageView)
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[highlightedBulletImageView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["highlightedBulletImageView": highlightedBulletImageView]))
        self.addConstraint(NSLayoutConstraint(item: highlightedBulletImageView, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 30))
        moveToIndex(0)
    }
    
    func moveToIndex(index: Int) {
        let currentImageView = self.unhighlightedBulletViewsCollection[index]
        if let highlightedBulletHorConstraint = highlightedBulletHorizontalConstraint {
            self.removeConstraint(highlightedBulletHorConstraint)
        }
        let newConstraint = NSLayoutConstraint(item: highlightedBulletImageView, attribute: .CenterX, relatedBy: .Equal, toItem: currentImageView, attribute: .CenterX, multiplier: 1.0, constant: 0)
        self.addConstraint(newConstraint)
        
        if let _ = self.highlightedBulletHorizontalConstraint {
            UIView.animateWithDuration(animationDuration) {
                self.layoutIfNeeded()
            }
        }
        
        self.highlightedBulletHorizontalConstraint = newConstraint
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
