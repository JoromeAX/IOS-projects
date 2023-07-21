//
//  WABarView.swift
//  WorkoutUIKit
//
//  Created by Roman Khancha on 16.07.2023.
//

import UIKit

extension WABarView {
    struct Data {
        let value: String
        let title: String
        let heightMultiple: Double
    }
}

final class WABarView: WABaseView {
    private let heightMultiple : Double
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.font = R.Fonts.helveticaRegular(with: 13)
        label.textColor = R.Colors.active
        return label
    }()
    
    private let barView: UIView = {
        let view = UIView()
        view.backgroundColor = R.Colors.active
        view.layer.cornerRadius = 2.5
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = R.Fonts.helveticaRegular(with: 9)
        label.textColor = R.Colors.inactive
        return label
    }()
    
    init(data: Data) {
        self.heightMultiple = data.heightMultiple
        super.init(frame: .zero)
        
        titleLabel.text = data.title.uppercased()
        valueLabel.text = data.value
    }
    
    required init?(coder: NSCoder) {
        self.heightMultiple = 0
        super.init(frame: .zero)
    }
}

extension WABarView {
    override func setupViews() {
        super.setupViews()
        
        setupView(valueLabel)
        setupView(barView)
        setupView(titleLabel)
    }
    
    override func constraintViews() {
        super.constraintViews()
        
        NSLayoutConstraint.activate([
            valueLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            valueLabel.heightAnchor.constraint(equalToConstant: 10),
            
            barView.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 7),
            barView.centerXAnchor.constraint(equalTo: centerXAnchor),
            barView.widthAnchor.constraint(equalToConstant: 17),
            barView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: heightMultiple * 0.8),
            
            titleLabel.topAnchor.constraint(equalTo: barView.bottomAnchor, constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 10)
        ])
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        
    }
}
