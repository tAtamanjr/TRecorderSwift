//
//  Route.swift
//  TRecorder
//
//  Created by Oleksandr Bolbat on 09.04.2026.
//

import SwiftUI

enum Route: Hashable {
    case NewGame
    case GameTurn
    case GameEnd
    case GameResult(_ gameHistory: GameHistory)
    case History
    case GameDetails(_ gameHistory: GameHistory)
}
