//
//  BaseView.swift
//  UIComponents
//
//  Created by Roman Khancha on 28.07.2023.
//

import UIKit

open class BaseView: UIView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required public init?(coder: NSCoder) {
        super.init(frame: .zero)
    }
}

extension BaseView {
    @objc open func setup() {}
}
