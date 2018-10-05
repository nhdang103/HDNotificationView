//
//  ViewController.swift
//  HDNotificationView-Demo
//
//  Created by VN_LW70130-M on 10/5/18.
//  Copyright © 2018 AnG Studio. All rights reserved.
//

import UIKit
import HDNotificationView

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func btnShowNotificationViewTouchUpInside(_ sender: Any?) {
        
        HDNotificationView.show(
            iconImage: UIImage(named: "Icon"),
            title: "Bé Yêu".uppercased(),
            message: "Kiến thức mỗi ngày \"Những điều lưu ý khi con bị chảy máu cam\"",
            fireTime: Date(),
            onTap: {
                
                
        })
        
    }


}

