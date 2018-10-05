//
//  HDNotificationView.swift
//  HDNotificationView
//
//  Created by VN_LW70130-M on 10/5/18.
//  Copyright © 2018 AnG Studio. All rights reserved.
//

import UIKit
import SnapKit

/// ----------------------------------------------------------------------------------
//  MARK: - NOTIFICATION VIEW APPEARANCE
/// ----------------------------------------------------------------------------------
public class HDNotificationAppearance: NSObject {
    
    /// Default appearance
    static let defaultAppearance = HDNotificationAppearance()
    
    /// Margin
    let marginTop: CGFloat      = 28.0
    let marginLeft: CGFloat     = 8.0
    let marginRight: CGFloat    = 8.0
    
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
//  MARK: - UTILITY
/// ----------------------------------------------------------------------------------
public extension HDNotificationView {
    
    fileprivate static var _curNotiView: HDNotificationView?
    class func show(iconImage: UIImage?, title: String?, message: String?, fireTime: Date?, onTap: (() -> Void)?) {
        
        /// Hide current notification view if needed
        if let __curNotiView = _curNotiView {
            __curNotiView._dismiss(animated: false)
        }
        
        /// New notification view
        let notiView = HDNotificationView(appearance: HDNotificationAppearance.defaultAppearance)
        notiView._onTabHandleBlock = onTap
        
        notiView._show()
    }
}

/// ----------------------------------------------------------------------------------
//  MARK: - NOTIFICATION VIEW
/// ----------------------------------------------------------------------------------
public class HDNotificationView: UIView {
    
    var appearance: HDNotificationAppearance!
    
    fileprivate var _viewBorderedContainer: UIView!
    fileprivate var _imgIcon: UIImageView!
    fileprivate var _lblTitle: UILabel!
    fileprivate var _lblMessage: UILabel!
    fileprivate var _lblTime: UILabel!
    fileprivate var _imgThumb: UIImageView?
    
    fileprivate var _onTabHandleBlock: (() -> Void)?
    
    fileprivate var _tapGesture: UITapGestureRecognizer?
    
    //  MARK: - INIT
    /// ----------------------------------------------------------------------------------
    init(appearance: HDNotificationAppearance) {
        super.init(frame: appearance.initRect())
        
        self.appearance = appearance
        self._layoutSubViews()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.appearance = HDNotificationAppearance.defaultAppearance
        self._layoutSubViews()
    }
    
    //  MARK: - LAYOUT SUBVIEWS
    /// ----------------------------------------------------------------------------------
    fileprivate func _layoutSubViews() {
        
        _layoutBackground()
        _layoutImageIcon()
        _layoutLabelTitle()
        _layoutLabelMessage()
        _layoutLabelTime()
        _layoutImageThumb()
        
        _setUpTapGesture()
        _setUpPanGesture()
    }
    fileprivate func _layoutBackground() {
        
        /// Bordered view container
        self._viewBorderedContainer = UIView()
        self._viewBorderedContainer.backgroundColor = self.appearance.backgroundSolidColor
        self._viewBorderedContainer.layer.cornerRadius = 8.0
        self._viewBorderedContainer.clipsToBounds = true
        
        self.addSubview(self._viewBorderedContainer)
        self._viewBorderedContainer.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview()
            maker.bottom.equalToSuperview()
            maker.leading.equalToSuperview()
            maker.trailing.equalToSuperview()
        }
        
        /// Shadown
        self.clipsToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
    }
    fileprivate func _layoutImageIcon() {
        
    }
    fileprivate func _layoutLabelTitle() {
        
    }
    fileprivate func _layoutLabelMessage() {
        
    }
    fileprivate func _layoutLabelTime() {
        
    }
    fileprivate func _layoutImageThumb() {
        
    }
    
    //  MARK: - GESTURE
    /// ----------------------------------------------------------------------------------
    fileprivate func _setUpTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(_handleTapGesture(gesture:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        
        self.addGestureRecognizer(tapGesture)
        self._tapGesture = tapGesture
    }
    fileprivate func _setUpPanGesture() {
        
    }
    
    @objc fileprivate func _handleTapGesture(gesture: UITapGestureRecognizer) {
        
        switch gesture.state {
        case .began:
            break
            
        case .changed:
            /// Dismiss
            self._dismiss(animated: true)
            
            /// Callback
            self._onTabHandleBlock?()
            self._onTabHandleBlock = nil
            
        case .ended:
            break
            
        case .possible, .cancelled, .failed:
            break

        }
    }
    
    //  MARK: - SHOWING
    /// ----------------------------------------------------------------------------------
    fileprivate func _show() {
        
        guard let _keyWindow = UIApplication.shared.keyWindow else {
            return
        }
        
        _keyWindow.addSubview(self)
        self.snp.makeConstraints { (maker) in
            maker.top.equalTo(self.appearance.marginTop)
            maker.leading.equalTo(self.appearance.marginLeft)
            maker.trailing.equalTo(-self.appearance.marginRight)
            maker.height.equalTo(self.appearance.sizeHeigth())
        }
    }
    
    //  MARK: - DISMISS
    /// ----------------------------------------------------------------------------------
    fileprivate func _dismiss(animated: Bool) {
        
        self.removeFromSuperview()
        HDNotificationView._curNotiView = nil
    }
    
}
