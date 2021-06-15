//
//  GameSettings.swift
//  XO-game
//
//  Created by Grigory Stolyarov on 03.03.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

final class GameSettings {
    
    static let instance = GameSettings()
    private let gameSettingsCaretaker = GameSettingsCaretaker()
    
    var gameMode: GameMode {
        didSet {
            gameSettingsCaretaker.saveGameMode(gameMode: gameMode)
        }
    }
    var gameType: GameType {
        didSet {
            gameSettingsCaretaker.saveGameType(gameType: gameType)
        }
    }
    
    private init() {
        gameMode = gameSettingsCaretaker.loadGameMode()
        gameType = gameSettingsCaretaker.loadGameType()
    }
    
}
