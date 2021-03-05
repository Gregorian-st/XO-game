//
//  MoveFunc.swift
//  XO-game
//
//  Created by Grigory Stolyarov on 04.03.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

func addMove(player: Player, gameboard: Gameboard, position: GameboardPosition, markViewPrototype: MarkView) {
    let command = MoveCommand(player: player, gameboard: gameboard, position: position, markViewPrototype: markViewPrototype)
    MoveInvoker.instance.addMoveCommand(command: command)
}
