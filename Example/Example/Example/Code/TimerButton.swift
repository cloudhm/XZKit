//
//  TimerButton.swift
//  XZKit
//
//  Created by mlibai on 2017/8/8.
//  Copyright © 2017年 mlibai. All rights reserved.
//

import UIKit
import XZKit

extension UIControlEvents {
    
    /// 倒计时结束，与 .valueChanged 相同。
    public static let timeout = UIControlEvents.valueChanged
    
}

/// 显示一个倒计时的 Button，当倒计时完成时，会触发 UIControlEvents.timeout（或 valueChanged）事件。
open class TimerButton: UIButton {
    
    let timerView: TimerControl = TimerControl()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        didInitialize()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        didInitialize()
    }
    
    private func didInitialize() {
        timerView.frame = bounds
        timerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(timerView, at: 0)
        
        timerView.isUserInteractionEnabled = false
        timerView.addTarget(self, action: #selector(timerViewWasTimeout(_:)), for: .valueChanged)
    }
    
    @objc public func timerViewWasTimeout(_ timerView: TimerControl) {
        sendActions(for: .timeout)
    }
    
}

