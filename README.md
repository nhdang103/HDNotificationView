![iOS](https://img.shields.io/badge/iOS-9.x%2B-blue.svg)
![Version](https://img.shields.io/badge/version-2.0.0-green.svg)
![Dependence](https://img.shields.io/badge/Dependence-SnapKit-orange.svg)
[![License](https://img.shields.io/badge/License-MIT-lightgrey.svg)](./License)

## Introduction
HDNotificationView appears notification view like system.

![Portrait Screenshot](https://github.com/nhdang103/HDNotificationView/blob/master/Assets/Images/iPhoneX_Portrait.png)
![Portrait Screenshot](https://github.com/nhdang103/HDNotificationView/blob/master/Assets/Images/iPhone_Portrait.png)

## Requirement
- iOS 9.0+

## Installation

**Carthage**
```
github "nhdang103/HDNotificationView"
```

**Manual**
- Add there files below to your project:
   - **HDNotificationView.swift**
   - **HDNotificationData.swift**
   - **HDNotificationAppearance.swift**
   
- Add **Snapkit** as a dependence framework to your project.

## Usage
```
let notiData = HDNotificationData(
            iconImage: UIImage(named: "Icon"),
            appTitle: "Notification View".uppercased(),
            title: "This is a sample of HDNotificationView ⏰",
            message: "This area that you can input some message to notify to user 🔔",
            time: "now")
        
HDNotificationView.show(data: notiData, onTap: nil, onDidDismiss: nil)
```


## License
HDNotificationView is available under the MIT License. See the [LICENSE](./License) for details.
