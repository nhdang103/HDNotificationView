//
//  HDNotificationViewAppearance.swift
//  HDNotificationView
//
//  Created by VN_LW70130-M on 10/5/18.
//  Copyright © 2018 AnG Studio. All rights reserved.
//

import UIKit

public class HDNotificationAppearance: NSObject {
    
    /// Default appearance
    public static let defaultAppearance = HDNotificationAppearance()
    
    /// Margin
    let viewMarginTop: CGFloat      = 8.0
    let viewMarginLeft: CGFloat     = 8.0
    let viewMarginRight: CGFloat    = 8.0
    let viewRoundCornerRadius: CGFloat = 13.0
    
    /// Size
    func viewSizeHeigth(notiData: HDNotificationData?) -> CGFloat {
        
        guard let _notiData = notiData else {
            return 0.0
        }
        
        var viewHeight: CGFloat = 0.0
        
        /// Top padding
        viewHeight += self.iconMarginTop
        
        /// Icon height
        viewHeight += self.iconSize.height
        
        /// Icon bot margin
        viewHeight += self.messageMarginTopToIcon
        
        /// Message height
        let messageWidth = self.viewSizeWidth() - (self.messageMarginLeft + self.messageMarginRight)
        let tempLabel = UILabel()
        tempLabel.attributedText = self.messageAttributedStringFrom(title: _notiData.title, message: _notiData.message)
        tempLabel.numberOfLines = self.messageTextLineNum
        let messageSize = tempLabel.sizeThatFits(CGSize(width: messageWidth, height: 0.0))
        viewHeight += messageSize.height
        
        /// Message bot margin
        viewHeight += self.messageMarginBot
        
        return viewHeight
//        return 108.0
    }
    func viewSizeWidth() -> CGFloat {
        return UIScreen.main.bounds.size.width - (viewMarginLeft + viewMarginRight)
    }
    
    /// Rect
    func viewInitRect(notiData: HDNotificationData?) -> CGRect {
        
        guard let _notiData = notiData else {
            return CGRect.zero
        }
        
        return CGRect(x: self.viewMarginLeft, y: self.viewMarginTop, width: self.viewSizeWidth(), height: self.viewSizeHeigth(notiData: _notiData))
    }
    
    /// Background
    public enum HDBackgroundType {
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
    public var backgroundType: HDBackgroundType = .blurLight
    var backgroundSolidColor: UIColor = UIColor.white
    
    /// Icon
    let iconSize: CGSize = CGSize(width: 20.0, height: 20.0)
    let iconMarginTop: CGFloat = 10.0
    let iconMarginLeft: CGFloat = 10.0
    let iconRoundCornerRadius: CGFloat = 4.0
    
    /// Title
    public var titleTextColor: UIColor = UIColor.black
    var titleTextFont: UIFont = UIFont.systemFont(ofSize: 13.0, weight: UIFont.Weight.regular)
    let titleMarginLeft: CGFloat = 7.0
    
    /// Message
    public var messageTextColor: UIColor = UIColor.black
    var messageTextFontSize: CGFloat = 15.0
    public var messageTextLineNum: Int = 3
    let messageMarginTopToIcon: CGFloat = 9.0
    let messageMarginLeft: CGFloat = 12.0
    let messageMarginRight: CGFloat = 16.0
    let messageMarginBot: CGFloat = 11.0
    
    /// Time
    var timeTextColor: UIColor = UIColor.black
    var timeTextFont: UIFont = UIFont.systemFont(ofSize: 13.0, weight: UIFont.Weight.regular)
    let timeMarginRight: CGFloat = 16.0
    
    //  MARK: - HELPER
    /// ----------------------------------------------------------------------------------
    func messageAttributedStringFrom(title: String?, message: String?) -> NSAttributedString {
        
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
                value: UIFont.systemFont(ofSize: self.messageTextFontSize, weight: .semibold),
                range: NSRange(location: 0, length: title!.count))
        }
        if isHaveMessage {
            attributedMessage.addAttribute(
                .font,
                value: UIFont.systemFont(ofSize: self.messageTextFontSize, weight: .regular),
                range: NSRange(location: isHaveTitle ? title!.count+1 : 0, length: message!.count))
        }
        
        let paragraphStyle              = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing      = 0.133 * self.messageTextFontSize
        paragraphStyle.lineBreakMode    = .byTruncatingTail
        attributedMessage.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: messageString.count))
        
        return attributedMessage
    }
}
