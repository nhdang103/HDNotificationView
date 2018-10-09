//
//  HDNotificationView.swift
//  HDNotificationView
//
//  Created by nhdang103 on 10/5/18.
//  Copyright © 2018 AnG Studio. All rights reserved.
//

import UIKit
import SnapKit

/// ----------------------------------------------------------------------------------
//  MARK: - UTILITY
/// ----------------------------------------------------------------------------------
public extension HDNotificationView {
    
    class func show(data: HDNotificationData?, onTap: (() -> Void)? = nil, onDidDismiss: (() -> Void)? = nil) -> HDNotificationView? {
        
        guard let _data = data else {
            return nil
        }
        
        /// New notification view
        let notiView = HDNotificationView(appearance: HDNotificationAppearance.defaultAppearance, notiData: _data)
        
        notiView.onTabHandleBlock = onTap
        notiView.onDidDismissBlock = onDidDismiss
        
        notiView.notiData = data
        notiView.loadingNotificationData()
        
        notiView.show(onComplete: nil)
        
        return notiView
    }
}

/// ----------------------------------------------------------------------------------
//  MARK: - NOTIFICATION VIEW
/// ----------------------------------------------------------------------------------
public class HDNotificationView: UIView {
    
    fileprivate static var _curNotiView: HDNotificationView?
    
    var appearance: HDNotificationAppearance
    var notiData: HDNotificationData?
    
    var constraintMarginTop: NSLayoutConstraint?
    var viewBorderedContainer: UIView!
    var imgIcon: UIImageView!
    var lblTitle: UILabel!
    var lblMessage: UILabel!
    var lblTime: UILabel!
    var imgThumb: UIImageView?
    
    var tapGesture: UITapGestureRecognizer?
    var panGesture: UIPanGestureRecognizer?
    
    var onTabHandleBlock: (() -> Void)?
    var onDidDismissBlock: (() -> Void)?
    
    //  MARK: - INIT
    /// ----------------------------------------------------------------------------------
    init(appearance: HDNotificationAppearance, notiData: HDNotificationData?) {
        
        self.appearance = appearance
        self.notiData = notiData
        
        super.init(frame: appearance.viewInitRect(notiData: notiData))
        self._layoutSubViews()
    }
    required init?(coder aDecoder: NSCoder) {
        
        self.appearance = HDNotificationAppearance.defaultAppearance
        
        super.init(coder: aDecoder)
        self._layoutSubViews()
    }
    
    //  MARK: - LAYOUT SUBVIEWS
    /// ----------------------------------------------------------------------------------
    private func _layoutSubViews() {
        
        _layoutBackground()
        _layoutImageIcon()
        _layoutLabelTitle()
        _layoutLabelMessage()
        _layoutLabelTime()
        _layoutImageThumb()
        
        _setUpTapGesture()
        _setUpPanGesture()
    }
    private func _layoutBackground() {
        
        let _appearance = self.appearance
        
        /// Bordered view container
        self.viewBorderedContainer = UIView()
        self.viewBorderedContainer.layer.cornerRadius = _appearance.viewRoundCornerRadius
        self.viewBorderedContainer.clipsToBounds = true
        
        self.addSubview(self.viewBorderedContainer)
        self.viewBorderedContainer.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview()
            maker.bottom.equalToSuperview()
            maker.leading.equalToSuperview()
            maker.trailing.equalToSuperview()
        }
        
        /// Blur view
        let blurView = UIVisualEffectView()
        blurView.effect = UIBlurEffect(style: _appearance.backgroundType.blurEffectType())
        self.viewBorderedContainer.addSubview(blurView)
        blurView.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview()
            maker.bottom.equalToSuperview()
            maker.leading.equalToSuperview()
            maker.trailing.equalToSuperview()
        }
        
        /// Shadown
        self.clipsToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
    }
    private func _layoutImageIcon() {
        
        let _appearance = self.appearance
        
        let imgIcon = UIImageView(frame: CGRect(origin: CGPoint.zero, size: _appearance.iconSize))
        imgIcon.layer.cornerRadius = _appearance.iconRoundCornerRadius
        imgIcon.clipsToBounds = true
        self.imgIcon = imgIcon
            
        self.viewBorderedContainer.addSubview(imgIcon)
        imgIcon.snp.makeConstraints { (maker) in
            maker.top.equalTo(_appearance.iconMargin.top)
            maker.left.equalTo(_appearance.iconMargin.left)
            maker.size.equalTo(_appearance.iconSize)
        }
    }
    private func _layoutLabelTitle() {
        
        let _appearance = self.appearance
        
        let lblTitle = UILabel()
        lblTitle.textColor = _appearance.titleTextColor
        lblTitle.font = _appearance.titleTextFont
        self.lblTitle = lblTitle
        
        self.viewBorderedContainer.addSubview(lblTitle)
        lblTitle.snp.makeConstraints { (maker) in
            maker.centerY.equalTo(self.imgIcon.snp.centerY)
            maker.leading.equalTo(self.imgIcon.snp.trailing).offset(_appearance.titleMargin.left)
        }
    }
    private func _layoutLabelMessage() {
        
        let _appearance = self.appearance
        
        let lblMessage = UILabel()
        lblMessage.textColor = _appearance.messageTextColor
        lblMessage.numberOfLines = _appearance.messageTextLineNum
        self.lblMessage = lblMessage
        
        self.viewBorderedContainer.addSubview(lblMessage)
        lblMessage.snp.makeConstraints { (maker) in
            maker.leading.equalTo(_appearance.messageMargin.left)
            maker.trailing.equalTo(-_appearance.messageMargin.right)
            maker.top.equalTo(self.imgIcon.snp.bottom).offset(_appearance.messageMargin.top)
            maker.bottom.lessThanOrEqualTo(0.0)
        }
    }
    private func _layoutLabelTime() {
        
        let _appearance = self.appearance
        
        let lblTime = UILabel()
        lblTime.textColor = _appearance.timeTextColor
        lblTime.font = _appearance.timeTextFont
        self.lblTime = lblTime
        
        let layoutPriority = lblTime.contentCompressionResistancePriority(for: .horizontal)
        let newLayoutPriority = UILayoutPriority(layoutPriority.rawValue + 1.0)
        lblTime.setContentCompressionResistancePriority(newLayoutPriority, for: .horizontal)
        
        self.viewBorderedContainer.addSubview(lblTime)
        lblTime.snp.makeConstraints { (maker) in
            maker.trailing.equalTo(-_appearance.timeMargin.right)
            
            maker.centerY.equalTo(self.lblTitle.snp.centerY)
            maker.leading.greaterThanOrEqualTo(self.lblTitle.snp.trailing).offset(_appearance.timeMargin.left)
        }
    }
    private func _layoutImageThumb() {
        
    }
    
    //  MARK: - LOADING CONTENT
    /// ----------------------------------------------------------------------------------
    func loadingNotificationData() {
        
        guard let _notiData = self.notiData else {
            return
        }
        
        let _appearance = self.appearance
        
        /// Icon
        self.imgIcon.image = _notiData.iconImage
        
        /// App Title
        self.lblTitle.text = _notiData.appTitle
        
        /// Title + Message
        self.lblMessage.attributedText = _appearance.messageAttributedStringFrom(title: _notiData.title, message: _notiData.message)
        
        /// Time
        self.lblTime.text = _notiData.time
    }
    
    //  MARK: - TAP GESTURE
    /// ----------------------------------------------------------------------------------
    private func _setUpTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(_handleTapGesture(gesture:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        
        self.addGestureRecognizer(tapGesture)
        self.tapGesture = tapGesture
    }
    @objc private func _handleTapGesture(gesture: UITapGestureRecognizer) {
        
        switch gesture.state {
        case .began:
            break
            
        case .ended:
            /// Dismiss
            self.dismiss(animated: true, onComplete: nil)
            
            /// Callback
            self.onTabHandleBlock?()
            self.onTabHandleBlock = nil
            
        case .possible, .cancelled, .failed, .changed:
            break

        }
    }
    
    //  MARK: - PAN GESTURE
    /// ----------------------------------------------------------------------------------
    private func _setUpPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(_handlePanGesture(gesture:)))
        panGesture.delegate = self
        
        self.addGestureRecognizer(panGesture)
        self.panGesture = panGesture
    }
    @objc private func _handlePanGesture(gesture: UIPanGestureRecognizer) {
        
        switch gesture.state {
        case .began:
            self._invalidateTimer()
            
        case .changed:
            guard let _constraintMarginTop = self.constraintMarginTop else {
                return
            }
            let translation = gesture.translation(in: self)
            var newConstraintConstant = _constraintMarginTop.constant + translation.y
            newConstraintConstant = min(newConstraintConstant, self.appearance.viewMargin.top)
            _constraintMarginTop.constant = newConstraintConstant
            
            gesture.setTranslation(CGPoint.zero, in: self)
            
        case .ended:
            /// Dismiss
            if self.frame.minY < -35.0 {
                self.dismiss(animated: true, onComplete: nil)
            }
                
            /// No dimiss
            else {
                self._setUpTimerScheduleToDismiss(halfTime: true)
                self._returnToDisplayPosition(animated: true, onComplete: nil)
            }
            
        case .possible, .cancelled, .failed:
            self._setUpTimerScheduleToDismiss(halfTime: true)
        }
    }
    
    //  MARK: - SHOW
    /// ----------------------------------------------------------------------------------
    public func show(onComplete: (() -> Void)?) {
        
        /// Hide current notification view if needed
        if let __curNotiView = HDNotificationView._curNotiView {
            __curNotiView.dismiss(animated: false, onComplete: nil)
        }
        
        /// Pre-condition
        guard let _notiData = self.notiData else {
            return
        }
        guard let _keyWindow = UIApplication.shared.keyWindow else {
            return
        }
        let _appearance = self.appearance
        
        _keyWindow.windowLevel = .statusBar
        
        _keyWindow.addSubview(self)
        self.snp.makeConstraints { (maker) in
            maker.leading.equalTo(_appearance.viewMargin.left)
            maker.trailing.equalTo(-_appearance.viewMargin.right)
            maker.height.equalTo(_appearance.viewSizeHeigth(notiData: _notiData))
            
            self.constraintMarginTop = maker.top.equalToSuperview().offset(_appearance.viewMarginTopPreDisplay(notiData: _notiData)).constraint.layoutConstraints.first
        }
        self.layoutIfNeeded()
        
        /// Saving
        HDNotificationView._curNotiView = self
        
        /// Animation
        self.constraintMarginTop?.constant = _appearance.viewMargin.top
        UIView.animate(
            withDuration: _appearance.animationDuration,
            delay: 0.0,
            options: .curveEaseOut,
            animations: {
                _keyWindow.layoutIfNeeded()
        },
            completion: { (finished) in

        })
        
        /// Shedule to dismiss
        self._setUpTimerScheduleToDismiss(halfTime: false)
    }
    
    //  MARK: - DISMISS
    /// ----------------------------------------------------------------------------------
    public func dismiss(animated: Bool, onComplete: (() -> Void)?) {
        
        self._invalidateTimer()
        
        guard let _notiData = self.notiData else {
            return
        }
        guard let _keyWindow = UIApplication.shared.keyWindow else {
            return
        }
        let _appearance = self.appearance
        
        /// Reset and callback
        func _resetAndCallback() {
            self.removeFromSuperview()
            UIApplication.shared.keyWindow?.windowLevel = .normal
            
            self.onDidDismissBlock?()
            onComplete?()
        }
        
        /// Animate dismiss
        if animated {
            HDNotificationView._curNotiView = nil
            
            self.constraintMarginTop?.constant = _appearance.viewMarginTopPreDisplay(notiData: _notiData)
            UIView.animate(
                withDuration: _appearance.animationDuration,
                delay: 0.0,
                options: .curveEaseOut,
                animations: {
                    _keyWindow.layoutIfNeeded()
                },
                completion: { (finished) in
                    _resetAndCallback()
                })
        }
        else {
            HDNotificationView._curNotiView = nil
            _resetAndCallback()
        }
    }
    
    private func _returnToDisplayPosition(animated: Bool, onComplete: (() -> Void)?) {
        
        guard let _keyWindow = UIApplication.shared.keyWindow else {
            return
        }
        let _appearance = self.appearance
        
        /// Animation
        self.constraintMarginTop?.constant = _appearance.viewMargin.top
        if animated {
            UIView.animate(
                withDuration: _appearance.returnPositionAnimationDuration,
                delay: 0.0,
                options: .curveEaseOut,
                animations: {
                    _keyWindow.layoutIfNeeded()
            },
                completion: { (finished) in
                    onComplete?()
            })
        }
        else {
            onComplete?()
        }
    }
    
    //  MARK: - TIMER
    /// ----------------------------------------------------------------------------------
    private var _timer: Timer?
    private func _invalidateTimer() {
        self._timer?.invalidate()
        self._timer = nil
    }
    private func _setUpTimerScheduleToDismiss(halfTime: Bool) {
        self._invalidateTimer()
        
        let _appearance = self.appearance
        self._timer = Timer.scheduledTimer(
            timeInterval: !halfTime ? _appearance.appearingDuration : _appearance.appearingDuration/2.0,
            target: self,
            selector: #selector(_handleTimerSheduleToDismiss),
            userInfo: nil,
            repeats: false)
        
    }
    @objc private func _handleTimerSheduleToDismiss() {
        self.dismiss(animated: true, onComplete: nil)
    }
}

/// ----------------------------------------------------------------------------------
//  MARK: - GESTURE DELEGATE
/// ----------------------------------------------------------------------------------
extension HDNotificationView: UIGestureRecognizerDelegate {
    
    public override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        guard let _panGesture = self.panGesture, gestureRecognizer == _panGesture else {
            return super.gestureRecognizerShouldBegin(gestureRecognizer)
        }

        return _panGesture.velocity(in: self).y < 0.0
    }
}
