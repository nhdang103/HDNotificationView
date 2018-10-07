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
        
        let notiData = HDNotificationData(
            iconImage: UIImage(named: "Icon"),
            appTitle: "Lịch Vạn Niên".uppercased(),
            title: "Quốc tang nguyên Tổng bí thư Đỗ Mười ⏱",
            message: "Quốc tang nguyên Tổng bí thư Đỗ Mười trong 2 ngày 06 và 07/10.",
            time: "now")
        
        HDNotificationView.show(data: notiData, onTap: nil, onDidDismiss: nil)
    }
}

