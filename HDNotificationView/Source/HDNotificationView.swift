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
    let marginTop: CGFloat      = 8.0
    let marginLeft: CGFloat     = 8.0
    let marginRight: CGFloat    = 8.0
    let roundCornerRadius: CGFloat = 13.0
    
    /// Size
    func sizeHeigth() -> CGFloat {
        return 108.0
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
        case blurExtraLight
//        case solidColor
        func blurEffectType() -> UIBlurEffect.Style {
            switch self {
            case .blurDark:         return .dark
            case .blurLight:        return .light
            case .blurExtraLight:   return .extraLight
            }
        }
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
    var titleTextFont: UIFont = UIFont.systemFont(ofSize: 13.0, weight: UIFont.Weight.regular)
    fileprivate let _titleMarginLeft: CGFloat = 7.0
    
    /// Message
    public var messageTextColor: UIColor = UIColor.black
    var messageTextFontSize: CGFloat = 15.0
    public var messageTextLineNum: Int = 3
    fileprivate let _messageMarginTopToIcon: CGFloat = 9.0
    fileprivate let _messageMarginLeft: CGFloat = 12.0
    fileprivate let _messageMarginRight: CGFloat = 16.0
    
    /// Time
    var timeTextColor: UIColor = UIColor.black
    var timeTextFont: UIFont = UIFont.systemFont(ofSize: 11.0)
    fileprivate let _timeMarginRight: CGFloat = 15.0
}

/// ----------------------------------------------------------------------------------
//  MARK: - UTILITY
/// ----------------------------------------------------------------------------------
public extension HDNotificationView {
    
    fileprivate static var _curNotiView: HDNotificationView?
    class func show(iconImage: UIImage?, appleTitle: String?, title: String?, message: String?, fireTime: Date?, onTap: (() -> Void)?) {
        
        /// Hide current notification view if needed
        if let __curNotiView = _curNotiView {
            __curNotiView._dismiss(animated: false)
        }
        
        /// New notification view
        let notiView = HDNotificationView(appearance: HDNotificationAppearance.defaultAppearance)
        notiView._onTabHandleBlock = onTap
        notiView._loadingNotificationData(iconImage: iconImage, appleTitle: appleTitle, title: title, message: message, fireTime: fireTime)
        
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
        self._viewBorderedContainer.layer.cornerRadius = self.appearance.roundCornerRadius
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
        blurView.effect = UIBlurEffect(style: self.appearance.backgroundType.blurEffectType())
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
            maker.leading.equalTo(self._imgIcon.snp.trailing).offset(self.appearance._titleMarginLeft)
        }
    }
    fileprivate func _layoutLabelMessage() {
        
        let lblMessage = UILabel()
        lblMessage.textColor = self.appearance.messageTextColor
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
    fileprivate func _loadingNotificationData(iconImage: UIImage?, appleTitle: String?, title: String?, message: String?, fireTime: Date?) {
        
        /// Icon
        self._imgIcon.image = iconImage
        
        /// App Title
        self._lblTitle.text = appleTitle
        
        /// Title + Message
        _lblMessage.attributedText = _messageAttributedStringFrom(appleTitle: appleTitle, title: title, message: message)
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
        
        _keyWindow.windowLevel = .statusBar
        
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
        
        UIApplication.shared.keyWindow?.windowLevel = .normal
    }
    
    //  MARK: - HELPER
    /// ----------------------------------------------------------------------------------
    fileprivate func _messageAttributedStringFrom(appleTitle: String?, title: String?, message: String?) -> NSAttributedString {
        
        var messageString: String = ""
        var isHaveTitle: Bool = false
        var isHaveMessage: Bool = false
        if let _title = title {
            isHaveTitle = true
            messageString += _title
        }
        if let _message = message {
            isHaveMessage = true
            if isHaveTitle {
                messageString += "\n"
            }
            messageString += _message
        }
        
        let attributedMessage = NSMutableAttributedString(string: messageString)
        if isHaveTitle {
            attributedMessage.addAttribute(
                .font,
                value: UIFont.systemFont(ofSize: self.appearance.messageTextFontSize, weight: .semibold),
                range: NSRange(location: 0, length: title!.count))
        }
        if isHaveMessage {
            attributedMessage.addAttribute(
                .font,
                value: UIFont.systemFont(ofSize: self.appearance.messageTextFontSize, weight: .regular),
                range: NSRange(location: isHaveTitle ? title!.count+1 : 0, length: message!.count))
        }
        
        let paragraphStyle              = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing      = 0.133 * self.appearance.messageTextFontSize
        paragraphStyle.lineBreakMode    = .byTruncatingTail
        attributedMessage.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: messageString.count))
        
        return attributedMessage
    }
    
}
