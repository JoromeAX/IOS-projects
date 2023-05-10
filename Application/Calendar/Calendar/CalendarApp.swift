//
//  CalendarApp.swift
//  Calendar
//
//  Created by Roman Khancha on 29.03.2023.
//

import SwiftUI

@main
struct CalendarApp: App {
    var body: some Scene {
        WindowGroup {
            let dateHolder = DateHolder()
            ContentView()
                .environmentObject(dateHolder )
        }
    }
}
