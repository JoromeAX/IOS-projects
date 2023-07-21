//
//  StatsView.swift
//  WorkoutUIKit
//
//  Created by Roman Khancha on 13.07.2023.
//

import UIKit

final class StatsView: WABaseInfoView {
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 15
        return view
    }()
    
    func configure(with items: [StatsItem]) {
        items.forEach {
            let itemVIew = StatsItemView()
            itemVIew.configure(with: $0)
            stackView.addArrangedSubview(itemVIew)
        }
    }
}

extension StatsView {
    override func setupViews() {
        super.setupViews()
        
        setupView(stackView)
    }
    
    override func constraintViews() {
        super.constraintViews()
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ])
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        
    }
}
