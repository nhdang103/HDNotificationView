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
        return 90.0
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
    fileprivate let _iconRoundCornerRadius: CGFloat = 4.0
    
    /// Title
    public var titleTextColor: UIColor = UIColor.black
    var titleTextFont: UIFont = UIFont.systemFont(ofSize: 12.0, weight: UIFont.Weight.semibold)
    fileprivate let _titleMarginLeftToIcon: CGFloat = 8.0
    
    /// Message
    public var messageTextColor: UIColor = UIColor.black
    var messageTextFont: UIFont = UIFont.systemFont(ofSize: 15.0)
    var messageTextLineNum: Int = 2
    fileprivate let _messageMarginTopToIcon: CGFloat = 8.0
    fileprivate let _messageMarginLeft: CGFloat = 12.0
    fileprivate let _messageMarginRight: CGFloat = 16.0
    
    /// Time
    var timeTextColor: UIColor = UIColor.black
    var timeTextFont: UIFont = UIFont.systemFont(ofSize: 12.0)
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
        notiView._loadingNotificationData(iconImage: iconImage, title: title, message: message, fireTime: fireTime)
        
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
        self._viewBorderedContainer.layer.cornerRadius = 8.0
        self._viewBorderedContainer.clipsToBounds = true
        
        self.addSubview(self._viewBorderedContainer)
        self._viewBorderedContainer.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview()
            maker.bottom.equalToSuperview()
            maker.leading.equalToSuperview()
            maker.trailing.equalToSuperview()
        }
        
        /// Blur view
        let blurView = UIVisualEffectView()
        blurView.effect = UIBlurEffect(style: .extraLight)
        self._viewBorderedContainer.addSubview(blurView)
        blurView.snp.makeConstraints { (maker) in
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
        
        let imgIcon = UIImageView(frame: CGRect(origin: CGPoint.zero, size: self.appearance._iconSize))
        imgIcon.layer.cornerRadius = self.appearance._iconRoundCornerRadius
        imgIcon.clipsToBounds = true
        self._imgIcon = imgIcon
            
        self._viewBorderedContainer.addSubview(imgIcon)
        imgIcon.snp.makeConstraints { (maker) in
            maker.top.equalTo(self.appearance._iconMarginTop)
            maker.left.equalTo(self.appearance._iconMarginLeft)
            maker.size.equalTo(self.appearance._iconSize)
        }
    }
    fileprivate func _layoutLabelTitle() {
        
        let lblTitle = UILabel()
        lblTitle.textColor = self.appearance.titleTextColor
        lblTitle.font = self.appearance.titleTextFont
        self._lblTitle = lblTitle
        
        self._viewBorderedContainer.addSubview(lblTitle)
        lblTitle.snp.makeConstraints { (maker) in
            maker.centerY.equalTo(self._imgIcon.snp.centerY)
            maker.leading.equalTo(self._imgIcon.snp.trailing).offset(self.appearance._titleMarginLeftToIcon)
        }
    }
    fileprivate func _layoutLabelMessage() {
        
        let lblMessage = UILabel()
        lblMessage.textColor = self.appearance.messageTextColor
        lblMessage.font = self.appearance.messageTextFont
        lblMessage.numberOfLines = self.appearance.messageTextLineNum
        self._lblMessage = lblMessage
        
        self._viewBorderedContainer.addSubview(lblMessage)
        lblMessage.snp.makeConstraints { (maker) in
            maker.leading.equalTo(self.appearance._messageMarginLeft)
            maker.trailing.equalTo(-self.appearance._messageMarginRight)
            maker.top.equalTo(self._imgIcon.snp.bottom).offset(self.appearance._messageMarginTopToIcon)
        }
    }
    fileprivate func _layoutLabelTime() {
        
    }
    fileprivate func _layoutImageThumb() {
        
    }
    
    //  MARK: - LOADING CONTENT
    /// ----------------------------------------------------------------------------------
    fileprivate func _loadingNotificationData(iconImage: UIImage?, title: String?, message: String?, fireTime: Date?) {
        
        /// Icon
        self._imgIcon.image = iconImage
        
        /// Title
        self._lblTitle.text = title
        
        /// Message
        if let _message = message {
            let paragraphStyle              = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing      = 0.75
            
            let attributedMessage = NSAttributedString(
                string: _message,
                attributes: [
                    .paragraphStyle: paragraphStyle
                ])
            _lblMessage.attributedText = attributedMessage
        }
        else {
            self._lblMessage.text = ""
        }
    }
    
    //  MARK: - TAP GESTURE
    /// ----------------------------------------------------------------------------------
    fileprivate func _setUpTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(_handleTapGesture(gesture:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        
        self.addGestureRecognizer(tapGesture)
        self._tapGesture = tapGesture
    }
    @objc fileprivate func _handleTapGesture(gesture: UITapGestureRecognizer) {
        
        switch gesture.state {
        case .began:
            break
            
        case .ended:
            /// Dismiss
            self._dismiss(animated: true)
            
            /// Callback
            self._onTabHandleBlock?()
            self._onTabHandleBlock = nil
            
        case .possible, .cancelled, .failed, .changed:
            break

        }
    }
    
    //  MARK: - PAN GESTURE
    /// ----------------------------------------------------------------------------------
    fileprivate func _setUpPanGesture() {
        
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
        
        /// Saving
        HDNotificationView._curNotiView = self
    }
    
    //  MARK: - DISMISS
    /// ----------------------------------------------------------------------------------
    fileprivate func _dismiss(animated: Bool) {
        
        self.removeFromSuperview()
        HDNotificationView._curNotiView = nil
    }
    
}
