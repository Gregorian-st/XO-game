//
//  MoveCommand.swift
//  XO-game
//
//  Created by Grigory Stolyarov on 04.03.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

class MoveCommand {
    
    let player: Player
    private weak var gameboard: Gameboard?
    public let markViewPrototype: MarkView
    let position: GameboardPosition
    
    init(player: Player, gameboard: Gameboard, position: GameboardPosition, markViewPrototype: MarkView) {
        self.player = player
        self.gameboard = gameboard
        self.position = position
        self.markViewPrototype = markViewPrototype
    }
    
    func execute(gameBoardView: GameboardView) {
        gameboard?.setPlayer(player, at: position)
        gameBoardView.placeMarkView(markViewPrototype.copy(), at: position)
    }
    
}
