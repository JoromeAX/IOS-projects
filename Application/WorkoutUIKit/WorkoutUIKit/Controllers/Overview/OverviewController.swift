//
//  OverviewController.swift
//  WorkoutUIKit
//
//  Created by Roman Khancha on 28.06.2023.
//

import UIKit

struct TrainingData {
    struct Data {
        let title: String
        let subTitle: String
        let isBool: Bool
    }
    
    let date: Date
    let items: [Data]
}

class OverviewController: WABaseController {
    private var dataSource: [TrainingData] = []
    
    private let navBar = OverviewNavBar()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = .clear
        return view
    }()
}

extension OverviewController {
    override func setupViews() {
        super.setupViews()
        
        view.setupView(navBar)
        view.setupView(collectionView)
    }
    
    override func constraintViews() {
        super.constraintViews()
        
        NSLayoutConstraint.activate([
            navBar.topAnchor.constraint(equalTo: view.topAnchor),
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: navBar.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    override func configureAppearence() {
        super.configureAppearence()
        
        navigationController?.navigationBar.isHidden = true
        
        collectionView.register(TrainingCellView.self, forCellWithReuseIdentifier: TrainingCellView.id)
        collectionView.register(SectionHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: SectionHeaderView.id)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        dataSource = [
            .init(date: Date(),
                  items: [
                    .init(title: "Warm Up Cardio", subTitle: "Stair Climber • 10 minutes", isBool: true),
                    .init(title: "High Intensity Cardio", subTitle: "Treadmill • 50 minutes", isBool: false),
                  ]),
            .init(date: Date(),
                  items: [
                    .init(title: "Warm Up Cardio", subTitle: "Stair Climber • 10 minutes", isBool: false),
                    .init(title: "Chest Workout", subTitle: "Bench Press • 3 sets • 10 reps", isBool: false),
                    .init(title: "Tricep Workout", subTitle: "Overhead Extension • 5 sets • 8 reps", isBool: false),
                  ]),
            .init(date: Date(),
                  items: [
                    .init(title: "Cardio Interval Workout", subTitle: "Treadmill • 60 minutes", isBool: false),
                  ])
        ]
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension OverviewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TrainingCellView.id, for: indexPath
        ) as? TrainingCellView else {
            return UICollectionViewCell()
        }
        
        let item = dataSource[indexPath.section].items[indexPath.row]
        
        let roundedType: CellRoundedType
        
        if indexPath.row == 0 && indexPath.row == dataSource[indexPath.section].items.count - 1 {
            roundedType = .all
        } else if indexPath.row == 0 {
            roundedType = .top
        } else if indexPath.row == dataSource[indexPath.section].items.count - 1 {
            roundedType = .bottom
        } else {
            roundedType = .notRounded
        }
        
        cell.configure(with: item.title, subTitle: item.subTitle, isDone: item.isBool, roundedType: roundedType)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        guard let view = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind, withReuseIdentifier: SectionHeaderView.id, for: indexPath
        ) as? SectionHeaderView else { return UICollectionReusableView() }
        
        view.configure(with: dataSource[indexPath.section].date)
        return view
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension OverviewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 32)
    }
    
}
