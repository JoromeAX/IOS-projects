//
//  PercentView.swift
//  WorkoutUIKit
//
//  Created by Roman Khancha on 10.07.2023.
//

import UIKit

extension TimerView {
    final class PercentView: WABaseView {
        private let stackView: UIStackView = {
            let view = UIStackView()
            view.axis = .vertical
            view.distribution = .fillProportionally
            view.spacing = 5
            return view
        }()
        
        private let percentLabel: UILabel = {
            let label = UILabel()
            label.font = R.Fonts.helveticaRegular(with: 23)
            label.textColor = R.Colors.titleGray
            label.textAlignment = .center
            return label
        }()
        
        private let subTitleLabel: UILabel = {
            let label = UILabel()
            label.font = R.Fonts.helveticaRegular(with: 10)
            label.textColor = R.Colors.inactive
            label.textAlignment = .center
            return label
        }()
        
        override func setupViews() {
            super.setupViews()
            
            setupView(stackView)
            stackView.addArrangedSubview(percentLabel)
            stackView.addArrangedSubview(subTitleLabel)
        }
        
        override func constraintViews() {
            super.constraintViews()
            
            NSLayoutConstraint.activate([
                stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
                stackView.topAnchor.constraint(equalTo: topAnchor),
                stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
                stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            ])
        }
        
        func configure(with title: String, andValue value: Int) {
            subTitleLabel.text = title
            percentLabel.text = "\(value)%"
        }
    }
}

