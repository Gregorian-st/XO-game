//
//  GameSettingsCaretaker.swift
//  XO-game
//
//  Created by Grigory Stolyarov on 03.03.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

class GameSettingsCaretaker {
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    func saveGameMode(gameMode: GameMode) {
        let key = "XOGameSettingsMode"
        UserDefaults.standard.setValue(gameMode.rawValue, forKey: key)
    }
    
    func loadGameMode() -> GameMode {
        let key = "XOGameSettingsMode"
        let value = UserDefaults.standard.integer(forKey: key)
        return GameMode(rawValue: value) ?? .humanVsHuman
    }
    
    func saveGameType(gameType: GameType) {
        let key = "XOGameSettingsType"
        UserDefaults.standard.setValue(gameType.rawValue, forKey: key)
    }
    
    func loadGameType() -> GameType {
        let key = "XOGameSettingsType"
        let value = UserDefaults.standard.integer(forKey: key)
        return GameType(rawValue: value) ?? .classic
    }
    
}
