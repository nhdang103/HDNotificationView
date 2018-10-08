//
//  HDNotificationViewAppearance.swift
//  HDNotificationView
//
//  Created by nhdang103 on 10/5/18.
//  Copyright © 2018 AnG Studio. All rights reserved.
//

import UIKit

public class HDNotificationAppearance: NSObject {
    
    /// Default appearance
    public static let defaultAppearance = HDNotificationAppearance()
    
    //  MARK: - NOTIFICATION VIEW
    /// ----------------------------------------------------------------------------------
    /// Margin
    let viewMargin: UIEdgeInsets = UIEdgeInsets(top: 8.0, left: 8.0, bottom: 0.0, right: 8.0)
    let viewRoundCornerRadius: CGFloat = 13.0
    
    func viewMarginTopPreDisplay(notiData: HDNotificationData?) -> CGFloat {
        guard let _notiData = notiData else {
            return 0.0
        }
        
        let offset = self.viewMargin.top + self.viewSizeHeigth(notiData: _notiData)
        return -offset
    }
    
    /// Size
    func viewInitRect(notiData: HDNotificationData?) -> CGRect {
        
        guard let _notiData = notiData else {
            return CGRect.zero
        }
        
        return CGRect(
            x: self.viewMargin.left,
            y: self.viewMarginTopPreDisplay(notiData: _notiData),
            width: self.viewSizeWidth(),
            height: self.viewSizeHeigth(notiData: _notiData))
    }
    
    func viewSizeHeigth(notiData: HDNotificationData?) -> CGFloat {
        
        guard let _notiData = notiData else {
            return 0.0
        }
        
        var viewHeight: CGFloat = 0.0
        
        /// Top padding
        viewHeight += self.iconMargin.top
        
        /// Icon height
        viewHeight += self.iconSize.height
        
        /// Icon bot margin
        viewHeight += self.messageMargin.top
        
        /// Message height
        let messageWidth = self.viewSizeWidth() - (self.messageMargin.left + self.messageMargin.right)
        let tempLabel = UILabel()
        tempLabel.attributedText = self.messageAttributedStringFrom(title: _notiData.title, message: _notiData.message)
        tempLabel.numberOfLines = self.messageTextLineNum
        let messageSize = tempLabel.sizeThatFits(CGSize(width: messageWidth, height: 0.0))
        viewHeight += messageSize.height
        
        /// Message bot margin
        viewHeight += self.messageMargin.bottom
        
        return viewHeight
    }
    func viewSizeWidth() -> CGFloat {
        return UIScreen.main.bounds.size.width - (self.viewMargin.left + self.viewMargin.right)
    }
    
    /// Timing
    public var animationDuration: TimeInterval = 0.4
    var returnPositionAnimationDuration: TimeInterval = 0.2
    public var appearingDuration: TimeInterval = 6.0
    
    //  MARK: - VIEW COMPONENTS
    /// ----------------------------------------------------------------------------------
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
    let iconMargin: UIEdgeInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 0.0, right: 0.0)
    let iconRoundCornerRadius: CGFloat = 4.0
    
    /// Title
    public var titleTextColor: UIColor = UIColor.black
    var titleTextFont: UIFont = UIFont.systemFont(ofSize: 13.0, weight: UIFont.Weight.regular)
    let titleMargin: UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 7.0, bottom: 0.0, right: 0.0)
    
    /// Message
    public var messageTextColor: UIColor = UIColor.black
    var messageTextFontSize: CGFloat = 15.0
    public var messageTextLineNum: Int = 3
    let messageMargin: UIEdgeInsets = UIEdgeInsets(top: 9.0, left: 12.0, bottom: 11.0, right: 16.0)
    
    /// Time
    var timeTextColor: UIColor = UIColor.black
    var timeTextFont: UIFont = UIFont.systemFont(ofSize: 13.0, weight: UIFont.Weight.regular)
    let timeMargin: UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 16.0)
    
    //  MARK: - HELPER
    /// ----------------------------------------------------------------------------------
    func messageAttributedStringFrom(title: String?, message: String?) -> NSAttributedString {
        
        var _title: String = ""
        if let __title = title {
            _title += __title
        }
        
        var _message: String = ""
        if let __message = message {
            _message += __message
        }
        
        let _newline: String = "\n"
        
        let paragraphStyle              = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing      = 0.133 * self.messageTextFontSize
        paragraphStyle.lineBreakMode    = .byTruncatingTail
        
        let _titleAttributedString = NSAttributedString(
            string: _title, attributes: [
                .font : UIFont.systemFont(ofSize: self.messageTextFontSize, weight: .semibold),
             .paragraphStyle : paragraphStyle
            ])
        let _newLineAttributedString = NSAttributedString(
            string: _newline, attributes: [
                .font : UIFont.systemFont(ofSize: self.messageTextFontSize, weight: .semibold),
                .paragraphStyle : paragraphStyle])
        let _messageAttributedString = NSAttributedString(
            string: _message, attributes: [
                .font : UIFont.systemFont(ofSize: self.messageTextFontSize, weight: .regular),
                .paragraphStyle : paragraphStyle])
        
        /// Final attributed string
        let _attributedString = NSMutableAttributedString()
        _attributedString.append(_titleAttributedString)
        if (_title.count > 0 && _message.count > 0) {
            _attributedString.append(_newLineAttributedString)
        }
        _attributedString.append(_messageAttributedString)
        
        return _attributedString
    }
}
