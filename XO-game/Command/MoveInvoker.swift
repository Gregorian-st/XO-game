//
//  MoveInvoker.swift
//  XO-game
//
//  Created by Grigory Stolyarov on 04.03.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

class MoveInvoker {
    
    static let instance = MoveInvoker()
    private init() {}
    
    private var commands = [MoveCommand]()
    private var commandsSorted = [MoveCommand]()
    var commandQueueIsNotEmpty: Bool {
        get {
            return commandsSorted.count > 0
        }
    }
    
    func addMoveCommand(command: MoveCommand) {
        commands.append(command)
        if commands.count == 10 {
            arrangeCommands()
        }
    }
    
    func executeMove(gameBoardView: GameboardView) {
        if commandsSorted.count == 0 {
            return
        }
        Log(action: .playerSetMark(player: commandsSorted[0].player, position: commandsSorted[0].position))
        commandsSorted[0].execute(gameBoardView: gameBoardView)
        commandsSorted.remove(at: 0)
    }
    
    func clear() {
        commands.removeAll()
        commandsSorted.removeAll()
    }
    
    private func arrangeCommands() {
        for i in (0...4) {
            commandsSorted.append(commands[i])
            commandsSorted.append(commands[i+5])
        }
    }
    
}
