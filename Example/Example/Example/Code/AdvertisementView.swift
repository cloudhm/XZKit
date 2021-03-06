//
//  AdvertisementView.swift
//  XZKit
//
//  Created by mlibai on 2017/8/9.
//  Copyright © 2017年 mlibai. All rights reserved.
//

import UIKit
import XZKit

open class AdvertisementView: UIView {
    
    open let advertisementImageView: UIImageView = UIImageView()
    
    open let backgroundImageView: UIImageView = UIImageView()
    
    open let timerButton: TimerButton = TimerButton()
    
    var contentInsets: UIEdgeInsets = .zero {
        didSet {
            setNeedsLayout()
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        didInitialize()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        didInitialize()
    }
    
    private func didInitialize() {
        backgroundImageView.image = UIApplication.shared.launchImage
        addSubview(backgroundImageView)
        
        advertisementImageView.contentMode = .scaleAspectFill
        addSubview(advertisementImageView)
        
        timerButton.frame = CGRect(x: 0, y: 0, width: 38, height: 38)
        timerButton.timerView.progressView.minimumTrackTintColor = UIColor.clear
        timerButton.timerView.progressView.maximumTrackTintColor = UIColor(0xf80809ff)
        timerButton.timerView.tintColor = UIColor.init(0x2b2b2bb2)
        timerButton.timerView.progressView.trackWidth = 2.5
        
        let shawdow = NSShadow()
        shawdow.shadowOffset = CGSize(width: 0, height: 2)
        shawdow.shadowColor = UIColor(0x0000007f)
        shawdow.shadowBlurRadius = 4.0
        let text = NSAttributedString(string: NSLocalizedString("跳过", comment: "跳过广告"), attributes: [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12.0),
            NSAttributedStringKey.shadow: shawdow,
            NSAttributedStringKey.foregroundColor: UIColor.white
            ]
        )
        timerButton.setAttributedTitle(text, for: .normal)
        addSubview(timerButton)
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        let bounds = self.bounds
        
        backgroundImageView.frame = bounds
        
        advertisementImageView.frame = UIEdgeInsetsInsetRect(bounds, contentInsets)
        
        timerButton.frame = CGRect(x: bounds.maxX - 15 - 38, y: 15, width: 38, height: 38)
    }
    
    
}
