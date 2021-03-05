//
//  PlayBlindState.swift
//  XO-game
//
//  Created by Grigory Stolyarov on 04.03.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

class PlayBlindState: GameState {

    var isMoveCompleted: Bool = false
    
    private weak var gameboard: Gameboard?
    private weak var gameBoardView: GameboardView?
    
    init(gameboard: Gameboard) {
        self.gameboard = gameboard
    }
    
    func begin() {}
    
    func addMark(at position: GameboardPosition) {}
    
    func execute(gameBoardView: GameboardView) {
        guard let gameboard = gameboard
        else { return }
        
        let referee = Referee(gameboard: gameboard)
        while MoveInvoker.instance.commandQueueIsNotEmpty && referee.determineWinner() == nil {
            MoveInvoker.instance.executeMove(gameBoardView: gameBoardView)
        }
    }
    
}
