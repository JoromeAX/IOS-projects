//
//  OverviewNavBar.swift
//  WorkoutUIKit
//
//  Created by Roman Khancha on 29.06.2023.
//

import UIKit

final class OverviewNavBar: WABaseView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = R.Title.NavBar.overview
        label.textColor = R.Colors.titleGray
        label.font = R.Fonts.helveticaRegular(with: 22)
        return label
    }()
    private let allWorkoutButton: WAButton = {
        let button = WAButton(with: .secondary)
        button.setTitile(R.Title.Overview.allWorkoutsButton)
        return button
    }()
    private let addButton: UIButton = {
        let button = UIButton()
        button.setImage(R.Images.Common.add, for: .normal)
        return button
    }()
    private let weekView = WeekView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addBottomBorder(with: R.Colors.separator, height: 1)
    }
    
    func allWorkoutsAction(_ action: Selector, with target: Any?) {
        allWorkoutButton.addTarget(target, action: action, for: .touchUpInside)
    }
    
    func addAdditingAction(_ action: Selector, with target: Any?) {
        allWorkoutButton.addTarget(target, action: action, for: .touchUpInside)
    }
}

extension OverviewNavBar {
    override func setupViews() {
        super.setupViews()
        
        setupView(allWorkoutButton)
        setupView(titleLabel)
        setupView(addButton)
        
        setupView(weekView)
    }
    
    override func constraintViews() {
        super.constraintViews()
        
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            addButton.heightAnchor.constraint(equalToConstant: 28),
            addButton.widthAnchor.constraint(equalToConstant: 28),
            
            allWorkoutButton.topAnchor.constraint(equalTo: addButton.topAnchor),
            allWorkoutButton.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: -15),
            
            titleLabel.centerYAnchor.constraint(equalTo: allWorkoutButton.centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: allWorkoutButton.trailingAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            
            weekView.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 15),
            weekView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            weekView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            weekView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            weekView.heightAnchor.constraint(equalToConstant: 47)
        ])
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        
        backgroundColor = .white
    }
}
