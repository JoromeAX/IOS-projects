//
//  Settings.swift
//  FindNumber
//
//  Created by Roman Khancha on 15.02.2023.
//

import Foundation

enum KeysUserDefaults {
    static let settingsGame = "setingsGame"
    static let recordGame = "recordGame"
}

struct SettingsGame: Codable {
    
    var timeState: Bool
    var timeForGame: Int
}

class Settings {
    
    static var shared = Settings()
    
    private let defaultSettings = SettingsGame(timeState: true, timeForGame: 30)
    
    var currentSettings: SettingsGame {
        
        get {
            if let data = UserDefaults.standard.object(forKey: KeysUserDefaults.settingsGame) as? Data {
                return try! PropertyListDecoder().decode(SettingsGame.self, from: data)
            } else {
                if let data = try? PropertyListEncoder().encode(defaultSettings) {
                    UserDefaults.standard.setValue(data, forKey: KeysUserDefaults.settingsGame)
                }
                return defaultSettings
            }
        }
        
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                UserDefaults.standard.setValue(data, forKey: KeysUserDefaults.settingsGame)
            }
        }
    }
    
    func resetSettings() {
        currentSettings = defaultSettings
    }
}
