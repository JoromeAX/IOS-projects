//
//  WeekdayView.swift
//  WorkoutUIKit
//
//  Created by Roman Khancha on 30.06.2023.
//

import UIKit

extension WeekView {
    final class WeekdayView: WABaseView {
        
        private let nameLabel: UILabel = {
            let lable = UILabel()
            lable.font = R.Fonts.helveticaRegular(with: 9)
            lable.textAlignment = .center
            return lable
        }()
        
        private let dateLabel: UILabel = {
            let lable = UILabel()
            lable.font = R.Fonts.helveticaRegular(with: 15)
            lable.textAlignment = .center
            return lable
        }()
        
        private let stackView: UIStackView = {
            let view = UIStackView()
            view.spacing = 3
            view.axis = .vertical
            return view
        }()
        
        func configure(with index: Int, and name: String) {
            let startOfWeek = Date().startOfWeek
            let currenrDay = startOfWeek.goForward(to: index)
            let day = Date.calendar.component(.day, from: currenrDay)
            
            let isToday = currenrDay.stripTime() == Date().stripTime()
            
            backgroundColor = isToday ? R.Colors.active : R.Colors.background
            
            nameLabel.text = name.uppercased()
            nameLabel.textColor = isToday ? .white : R.Colors.inactive
            
            dateLabel.text = "\(day)"
            dateLabel.textColor = isToday ? .white : R.Colors.inactive
        }
    }
}


extension WeekView.WeekdayView {
    override func setupViews() {
        super.setupViews()
        
        setupView(stackView)
        
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(dateLabel)
    }
    
    override func constraintViews() {
        super.constraintViews()
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        
        layer.cornerRadius = 5
        layer.masksToBounds = true
    }
}
