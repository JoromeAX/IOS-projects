//
//  BaseViewController.swift
//  UIComponents
//
//  Created by Roman Khancha on 28.07.2023.
//

import UIKit

open class BaseViewController: UIViewController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
}

extension BaseViewController {
    @objc open func setup() {}
}
