//
//  XRActivityInditor.swift
//  XRVideoPlayer-master
//
//  Created by xuran on 16/4/25.
//  Copyright © 2016年 黯丶野火. All rights reserved.
//

/**
 *  @brief  视频加载activityIndicator
 *
 *  @by     黯丶野火
 */

import UIKit

class XRActivityInditor: UIView {

    fileprivate lazy var activityInditor: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    var isAnimating: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.isUserInteractionEnabled = false
        self.layer.cornerRadius = 10.0
        self.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        activityInditor.center = CGPoint(x: self.frame.width * 0.5, y: self.frame.height * 0.5)
        isAnimating = activityInditor.isAnimating
        self.addSubview(activityInditor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        activityInditor.center = CGPoint(x: self.frame.width * 0.5, y: self.frame.height * 0.5)
    }
    
    func startAnimation() -> Void {
        if !activityInditor.isAnimating {
            activityInditor.startAnimating()
            self.isHidden = false
            isAnimating = activityInditor.isAnimating
        }
    }
    
    func stopAnimation() -> Void {
        if activityInditor.isAnimating {
            activityInditor.stopAnimating()
            self.isHidden = true
            isAnimating = activityInditor.isAnimating
        }
    }
}

