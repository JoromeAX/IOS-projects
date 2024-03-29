//
//  MonthlyPerformanceView.swift
//  WorkoutUIKit
//
//  Created by Roman Khancha on 18.07.2023.
//

import UIKit

final class MonthlyPerformanceView: WABaseInfoView {
    private let chartsView = WAChartsView()
    
    func configure(with items: [WAChartsView.Data], topChartOffset: Int = 10) {
        chartsView.configure(with: items, topChartOffset: topChartOffset)
    }
}

extension MonthlyPerformanceView {
    override func setupViews() {
        super.setupViews()
        
        setupView(chartsView)
    }
    
    override func constraintViews() {
        super.constraintViews()
        
        NSLayoutConstraint.activate([
            chartsView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            chartsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            chartsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            chartsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ])
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        
    }
}
