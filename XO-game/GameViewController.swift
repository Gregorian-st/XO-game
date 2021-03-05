//
//  GameViewController.swift
//  XO-game
//
//  Created by Evgeny Kireev on 25/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    private let gameBoard = Gameboard()
    private var currentState: GameState! {
        didSet {
            currentState.begin()
        }
    }
    private let gameSettings = GameSettings.instance
    
    private lazy var referee = Referee(gameboard: gameBoard)
    
    private var counter = 0
    private var counterBlind = 0
    
    @IBOutlet var gameboardView: GameboardView!
    @IBOutlet var firstPlayerTurnLabel: UILabel!
    @IBOutlet var secondPlayerTurnLabel: UILabel!
    @IBOutlet var winnerLabel: UILabel!
    @IBOutlet var restartButton: UIButton!
    
    @IBAction func returnButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindFromGame", sender: self)
    }
    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        Log(action: .restartGame)
        setFirstState()
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setFirstState()
        
        gameboardView.onSelectPosition = { [weak self] position in
            guard let self = self else { return }
            if self.gameSettings.gameType == .classic {
                self.currentState.addMark(at: position)
                if self.currentState.isMoveCompleted {
                    self.counter += 1
                    self.setNextState()
                }
            } else {
                self.currentState.addMark(at: position)
                if self.currentState.isMoveCompleted {
                    self.counter += 1
                    if self.counter == 5 {
                        self.counterBlind += 1
                        self.setNextState()
                    }
                }
            }
        }
    }
    
    // MARK: Program Logic
    
    private func setFirstState() {
        gameboardView.clear()
        gameBoard.clear()
        MoveInvoker.instance.clear()
        counter = 0
        
        if gameSettings.gameType == .classic {
            setFirstStateClassic()
        } else {
            setFirstStateBlind()
        }
    }
    
    private func setFirstStateClassic() {
        let player = Player.first
        currentState = PlayerState(player: player, gameViewController: self,
                                   gameBoard: gameBoard, gameBoardView: gameboardView, markViewPrototype: player.markViewPrototype)
    }
    
    private func setFirstStateBlind() {
        counterBlind = 0
        let player = Player.first
        currentState = PlayerBlindState(player: player, gameViewController: self,
                                        gameBoard: gameBoard, gameBoardView: gameboardView, markViewPrototype: player.markViewPrototype)
    }
    
    private func setNextState() {
        if gameSettings.gameType == .classic {
            setNextStateClassic()
        } else {
            setNextStateBlind()
        }
    }
    
    private func setNextStateClassic() {
        if let winner = referee.determineWinner() {
            currentState = GameOverState(winner: winner, gameViewController: self)
            return
        }
        
        if counter >= 9 {
            currentState = GameOverState(winner: nil, gameViewController: self)
            return
        }
        
        if let playerInputState = currentState as? PlayerState {
            switch gameSettings.gameMode {
            case .humanVsHuman:
                let player = playerInputState.player.next
                currentState = PlayerState(player: player, gameViewController: self,
                                           gameBoard: gameBoard, gameBoardView: gameboardView, markViewPrototype: player.markViewPrototype)
            case .humanVsAI:
                if playerInputState.player == .first {
                    let player = playerInputState.player.nextAI
                    currentState = AIState(player: player, gameViewController: self,
                                           gameBoard: gameBoard, gameBoardView: gameboardView, markViewPrototype: player.markViewPrototype)
                    currentState.addMark(at: GameboardPosition.init(column: 0, row: 0))
                    counter += 1
                    setNextState()
                }
            }
        }
        
        if let playerInputState = currentState as? AIState {
            let player = playerInputState.player.next
            currentState = PlayerState(player: player, gameViewController: self,
                                       gameBoard: gameBoard, gameBoardView: gameboardView, markViewPrototype: player.markViewPrototype)
        }
    }
    
    private func setNextStateBlind() {
        gameboardView.clear()
        if counterBlind < 2 {
            switch gameSettings.gameMode {
            case .humanVsHuman:
                counter = 0
                if let playerInputState = currentState as? PlayerBlindState {
                    let player = playerInputState.player.next
                    currentState = PlayerBlindState(player: player, gameViewController: self,
                                                    gameBoard: gameBoard, gameBoardView: gameboardView, markViewPrototype: player.markViewPrototype)
                }
            case .humanVsAI:
                if let playerInputState = currentState as? PlayerBlindState {
                    let player = playerInputState.player.nextAI
                    currentState = AIBlindState(player: player, gameViewController: self,
                                                gameBoard: gameBoard, gameBoardView: gameboardView, markViewPrototype: player.markViewPrototype)
                    for _ in (0...4) {
                        currentState.addMark(at: GameboardPosition.init(column: 0, row: 0))
                    }
                    counterBlind += 1
                    setNextState()
                }
            }
        } else {
            currentState = PlayBlindState(gameboard: gameBoard)
            (currentState as! PlayBlindState).execute(gameBoardView: gameboardView)
            
            if let winner = referee.determineWinner() {
                currentState = GameOverState(winner: winner, gameViewController: self)
                return
            }
            
            currentState = GameOverState(winner: nil, gameViewController: self)
            currentState.begin()
            
        }
    }
}
