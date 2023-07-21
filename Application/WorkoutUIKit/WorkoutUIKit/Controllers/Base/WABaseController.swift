//
//  BaseController.swift
//  WorkoutUIKit
//
//  Created by Roman Khancha on 28.06.2023.
//

import UIKit

enum NavigationBarPosition {
    case left
    case right
}

class WABaseController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        constraintViews()
        configureAppearence()
    }
}

@objc extension WABaseController {
    func setupViews() {}
    func constraintViews() {}
    
    func configureAppearence() {
        view.backgroundColor = R.Colors.background
    }
    
    func navBarLeftButtonHanler() {
        print("NavBar left button tapped")
    }
    
    func navBarRightButtonHanler() {
        print("NavBar right button tapped")
    }
}

extension WABaseController {
    func addNavigationBarButton(at position: NavigationBarPosition, with title: String) {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(R.Colors.active, for: .normal)
        button.setTitleColor(R.Colors.inactive, for: .disabled)
        button.titleLabel?.font = R.Fonts.helveticaRegular(with: 17)
        
        switch position {
        case .left:
            button.addTarget(self, action: #selector(navBarLeftButtonHanler), for: .touchUpInside)
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        case .right:
            button.addTarget(self, action: #selector(navBarRightButtonHanler), for: .touchUpInside)
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        }
    }
}
