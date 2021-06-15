//
//  Player.swift
//  XO-game
//
//  Created by Evgeny Kireev on 26/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

public enum Player: CaseIterable {
    case first
    case second
    case secondAI
    
    var next: Player {
        switch self {
        case .first: return .second
        default: return .first
        }
    }
    
    var nextAI: Player {
        switch self {
        case .first: return .secondAI
        default: return .first
        }
    }
    
    var markViewPrototype: MarkView {
        switch self {
        case .first:
            return XView()
        case .second, .secondAI:
            return OView()
        }
    }
}
