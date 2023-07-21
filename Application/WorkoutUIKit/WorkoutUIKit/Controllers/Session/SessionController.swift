//
//  SessionController.swift
//  WorkoutUIKit
//
//  Created by Roman Khancha on 28.06.2023.
//

import UIKit

class SessionController: WABaseController {
    private let timerView = TimerView()
    private let statsView = StatsView(with: R.Title.Session.workoutStats)
    private let stepsView = StepsView(with: R.Title.Session.stepsCounter)
    
    private let timerDuration = 15.0
    
    override func navBarLeftButtonHanler() {
        if timerView.state == .isStopped {
            timerView.startTimer { progress in
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.navBarRightButtonHanler()
                    print(progress)
                }
            }
        } else {
            timerView.pauseTimer()
        }
        
        timerView.state = timerView.state == .isRunning ? .isStopped : .isRunning
        addNavigationBarButton(at: .left,
                               with: timerView.state == .isRunning
                               ? R.Title.Session.navBarPause : R.Title.Session.navBarStart)
    }
    
    override func navBarRightButtonHanler() {
        timerView.stopTimer()
        timerView.state = .isStopped
        
        addNavigationBarButton(at: .left, with: R.Title.Session.navBarStart)
    }
}

extension SessionController {
    override func setupViews() {
        super.setupViews()
        
        view.setupView(timerView)
        view.setupView(statsView)
        view.setupView(stepsView)
    }
    
    override func constraintViews() {
        super.constraintViews()
        
        NSLayoutConstraint.activate([
            timerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            timerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            timerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            statsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            statsView.topAnchor.constraint(equalTo: timerView.bottomAnchor, constant: 10),
            statsView.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -7.5),
            
            stepsView.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 7.5),
            stepsView.topAnchor.constraint(equalTo: statsView.topAnchor),
            stepsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            stepsView.heightAnchor.constraint(equalTo: statsView.heightAnchor)
        ])
    }
    
    override func configureAppearence() {
        super.configureAppearence()
        
        title = R.Title.NavBar.session
        navigationController?.tabBarItem.title = R.Title.TabBar.title(for: .session)
        
        addNavigationBarButton(at: .left, with: R.Title.Session.navBarStart)
        addNavigationBarButton(at: .right, with: R.Title.Session.navBarFinish)
        
        timerView.configure(with: timerDuration, progress: 0)
        timerView.callBack = { [weak self] in
            self?.navBarRightButtonHanler()
        }
        
        statsView.configure(with: [.heartRate(value: "155"),
                                   .averagePace(value: "8'20''"),
                                   .totalSteps(value: "7,682"),
                                   .totalDistance(value: "8.25")])
        
        stepsView.configure(with: [.init(value: "8k", title: "2/13", heightMultiple: 1),
                                   .init(value: "7k", title: "2/14", heightMultiple: 0.8),
                                   .init(value: "5k", title: "2/15", heightMultiple: 0.6),
                                   .init(value: "6k", title: "2/16", heightMultiple: 0.7)])
    }
}
