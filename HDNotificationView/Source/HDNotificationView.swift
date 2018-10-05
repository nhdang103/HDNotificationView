//
//  HDNotificationView.swift
//  HDNotificationView
//
//  Created by VN_LW70130-M on 10/5/18.
//  Copyright © 2018 AnG Studio. All rights reserved.
//

import UIKit

/// ----------------------------------------------------------------------------------
//  MARK: - UTILITY
/// ----------------------------------------------------------------------------------
extension HDNotificationView {
    
    
}

class HDNotificationAppearance: NSObject {
    
    /// Default appearance
    static let defaultAppearance = HDNotificationAppearance()
    
    /// Margin
    let marginTop: CGFloat = 8.0
    let marginLeft: CGFloat = 8.0
    let marginRight: CGFloat = 8.0
    
    /// Size
    func sizeHeigth() -> CGFloat {
        return marginTop + 100.0
    }
    func sizeWidth() -> CGFloat {
        return UIScreen.main.bounds.size.width - (marginLeft + marginRight)
    }
    
    /// Rect
    func initRect() -> CGRect {
        return CGRect(x: self.marginLeft, y: self.marginTop, width: self.sizeWidth(), height: self.sizeHeigth())
    }
    
    /// Background
    enum HDBackgroundType {
        case blurDark
        case blurLight
        case blurLightExtra
        case solidColor
    }
    var backgroundType: HDBackgroundType = .blurLight
    var backgroundSolidColor: UIColor = UIColor.white
    
    /// Icon
    fileprivate let _iconSize: CGSize = CGSize(width: 20.0, height: 20.0)
    fileprivate let _iconMarginTop: CGFloat = 10.0
    fileprivate let _iconMarginLeft: CGFloat = 10.0
    fileprivate let _iconRoundCorner: CGFloat = 3.0
    
    /// Title
    var titleTextColor: UIColor = UIColor.black
    var titleTextFont: UIFont = UIFont.systemFont(ofSize: 11.0)
    fileprivate let _titleMarginLeftToIcon: CGFloat = 8.0
    
    /// Message
    var messageTextColor: UIColor = UIColor.black
    var messageTextFont: UIFont = UIFont.systemFont(ofSize: 11.0)
    var messageTextLineNum: Int = 2
    fileprivate let _messageMarginTopToIcon: CGFloat = 8.0
    fileprivate let _messageMarginLeft: CGFloat = 13.0
    fileprivate let _messageMarginRight: CGFloat = 16.0
    
    /// Time
    var timeTextColor: UIColor = UIColor.black
    var timeTextFont: UIFont = UIFont.systemFont(ofSize: 11.0)
    fileprivate let _timeMarginRight: CGFloat = 16.0
}

/// ----------------------------------------------------------------------------------
//  MARK: - NOTIFICATION VIEW
/// ----------------------------------------------------------------------------------
class HDNotificationView: UIView {
    
    fileprivate var _imgIcon: UIImageView!
    fileprivate var _lblTitle: UILabel!
    fileprivate var _lblMessage: UILabel!
    fileprivate var _lblTime: UILabel!
    fileprivate var _imgThumb: UIImageView?
    
    //  MARK: - INIT
    /// ----------------------------------------------------------------------------------
    init(appearance: HDNotificationAppearance) {
        super.init(frame: appearance.initRect())
        self._layoutSubViews()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self._layoutSubViews()
    }
    
    //  MARK: - LAYOUT SUBVIEWS
    /// ----------------------------------------------------------------------------------
    fileprivate func _layoutSubViews() {
        
        /// Background
        
        /// Icon
        
        /// Title
        
        /// Message
        
        /// Time
        
        /// Thumb image
        
        
    }
    
}
