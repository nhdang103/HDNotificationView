//
//  HDNotificationData.swift
//  HDNotificationView
//
//  Created by nhdang103 on 10/6/18.
//  Copyright © 2018 AnG Studio. All rights reserved.
//

import Foundation

public class HDNotificationData: NSObject {
    
    public var iconImage: UIImage?
    public var appTitle: String?
    public var title: String?
    public var message: String?
    public var time: String?
    
    public init(iconImage: UIImage?, appTitle: String?, title: String?, message: String?, time: String?) {
        
        self.iconImage  = iconImage
        self.appTitle   = appTitle
        self.title      = title
        self.message    = message
        self.time       = time
        
        super.init()
    }
}
