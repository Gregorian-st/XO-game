//
//  PlayerBlindState.swift
//  XO-game
//
//  Created by Grigory Stolyarov on 04.03.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

class PlayerBlindState: GameState {

    var isMoveCompleted: Bool = false
    
    public let player: Player
    private weak var gameViewController: GameViewController?
    private weak var gameBoardView: GameboardView?
    private weak var gameBoard: Gameboard?
    
    public let markViewPrototype: MarkView
    
    init(player: Player, gameViewController: GameViewController, gameBoard: Gameboard, gameBoardView: GameboardView, markViewPrototype: MarkView) {
        self.player = player
        self.gameViewController = gameViewController
        self.gameBoard = gameBoard
        self.gameBoardView = gameBoardView
        self.markViewPrototype = markViewPrototype
    }
    
    func begin() {
        switch player {
        case .first:
            gameViewController?.firstPlayerTurnLabel.isHidden = false
            gameViewController?.secondPlayerTurnLabel.isHidden = true
        case .second:
            gameViewController?.firstPlayerTurnLabel.isHidden = true
            gameViewController?.secondPlayerTurnLabel.text = "2nd player"
            gameViewController?.secondPlayerTurnLabel.isHidden = false
        case .secondAI:
            gameViewController?.firstPlayerTurnLabel.isHidden = true
            gameViewController?.secondPlayerTurnLabel.text = "Computer"
            gameViewController?.secondPlayerTurnLabel.isHidden = false
        }
        
        gameViewController?.winnerLabel.isHidden = true
    }
    
    func addMark(at position: GameboardPosition) {
        guard let gameBoardView = gameBoardView,
              let gameboard = gameBoard,
              gameBoardView.canPlaceMarkView(at: position) else {
            isMoveCompleted = false
            return
        }
        
        addMove(player: player, gameboard: gameboard, position: position, markViewPrototype: markViewPrototype)
        
        gameBoardView.placeMarkView(markViewPrototype.copy(), at: position)
        isMoveCompleted = true
    }
}
