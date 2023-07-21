//
//  ProgressController.swift
//  WorkoutUIKit
//
//  Created by Roman Khancha on 28.06.2023.
//

import UIKit

final class ProgressController: WABaseController {
    private let dailyPerformacneView = DailyPerformance(with: R.Title.Progress.dailyPerformance,
                                                    buttonTitle: R.Title.Progress.last7Days)
    
    private let monthlyPerformacneView = MonthlyPerformanceView(with: R.Title.Progress.monthlyPerformance,
                                                    buttonTitle: R.Title.Progress.last10Months)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ProgressController {
    override func setupViews() {
        super.setupViews()
        
        view.setupView(dailyPerformacneView)
        view.setupView(monthlyPerformacneView)
    }
    
    override func constraintViews() {
        super.constraintViews()
        
        NSLayoutConstraint.activate([
            dailyPerformacneView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            dailyPerformacneView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            dailyPerformacneView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            dailyPerformacneView.heightAnchor.constraint(equalTo: dailyPerformacneView.widthAnchor, multiplier: 0.68),
            
            monthlyPerformacneView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            monthlyPerformacneView.topAnchor.constraint(equalTo: dailyPerformacneView.bottomAnchor, constant: 15),
            monthlyPerformacneView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            monthlyPerformacneView.heightAnchor.constraint(equalTo: monthlyPerformacneView.widthAnchor, multiplier: 1.06)
        ])
    }
    
    override func configureAppearence() {
        super.configureAppearence()
        
        title = R.Title.NavBar.progress
        navigationController?.tabBarItem.title = R.Title.TabBar.title(for: .progress)
        
        addNavigationBarButton(at: .left, with: R.Title.Progress.navBarLeft)
        addNavigationBarButton(at: .right, with: R.Title.Progress.navBarRight)
        
        dailyPerformacneView.configure(with: [.init(value: "1", title: "Mon", heightMultiple: 0.2),
                                              .init(value: "2", title: "Tue", heightMultiple: 0.4),
                                              .init(value: "3", title: "Wen", heightMultiple: 0.6),
                                              .init(value: "4", title: "Thu", heightMultiple: 0.8),
                                              .init(value: "5", title: "Fri", heightMultiple: 1),
                                              .init(value: "6", title: "Sat", heightMultiple: 0.6),
                                              .init(value: "7", title: "Sun", heightMultiple: 0.4)])
        
        monthlyPerformacneView.configure(with: [.init(value: 45, title: "Mar"),
                                                .init(value: 55, title: "Apr"),
                                                .init(value: 60, title: "May"),
                                                .init(value: 65, title: "Jun"),
                                                .init(value: 70, title: "Jul"),
                                                .init(value: 80, title: "Aug"),
                                                .init(value: 65, title: "Sep"),
                                                .init(value: 45, title: "Oct"),
                                                .init(value: 30, title: "Nov"),
                                                .init(value: 15, title: "Dec")],
                                         topChartOffset: 10)
    }
}
