//
//  Previews.swift
//  TRecorder
//
//  Created by Oleksandr Bolbat on 04.04.2026.
//

import Foundation
import SwiftUI


func mainMenuPreview() -> any View {
    return MainMenuView(model: Model())
}

func newGamePreview() -> any View {
    return NewGameView().environmentObject(Model())
}


func gameTurnPreview() -> any View {
    return GameTurnView(gameData: GameData(["John", "Max", "Jim", "Dave"])).environmentObject(Model())
}

func endPreview() -> any View {
    let gameData = GameData(["John", "Max", "David"])
    
    gameData.players[0].score = [55]
    gameData.players[1].score = [75]
    gameData.players[2].score = [65]

    gameData.players[0].dices = 0
    gameData.players[1].dices = 5
    gameData.players[2].dices = 1
    
    return EndView(gameData: gameData).environmentObject(Model())
}

func resultPreview() -> any View {
    let gameHistory: GameHistory = GameHistory([])
    
    gameHistory.players.append(PlayerHistory("John", [15, 5, 7]))
    gameHistory.players.append(PlayerHistory("Max", [10, 1, 6]))
    gameHistory.players.append(PlayerHistory("David", [13, 6, 3]))
    
    return ResultView(gameHistory: gameHistory).environmentObject(Model())
}

func gameHistoryPreview() -> any View {
    let gameHistory: GameHistory = GameHistory([])
    
    gameHistory.players.append(PlayerHistory("John", [15, 5, 7]))
    gameHistory.players.append(PlayerHistory("Max", [10, 1, 6]))
    gameHistory.players.append(PlayerHistory("David", [13, 6, 3]))
    
    return GameHistoryView(gameHistory: gameHistory).environmentObject(Model())
}
