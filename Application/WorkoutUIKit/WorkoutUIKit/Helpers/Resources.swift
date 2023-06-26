//
//  Resouces.swift
//  WorkoutUIKit
//
//  Created by Roman Khancha on 26.06.2023.
//

import UIKit

enum Resources {
    enum Colors {
        static let acrive = UIColor(hexString: "#437BFE")
        static let inacrive = UIColor(hexString: "#929DA5")
        
        static let separator = UIColor(hexString: "#E8ECEF")
    }
    
    enum Title {
        enum TabBar {
            static let overview = "Overview"
            static let session = "Session"
            static let progress = "Progress"
            static let settings = "Settings"
        }
    }
    
    enum Image {
        enum TabBar {
            static let overview = UIImage(named: "overview_tab")
            static let session = UIImage(named: "session_tab")
            static let progress = UIImage(named: "progress_tab")
            static let settings = UIImage(named: "settings_tab")
        }
    }
}
