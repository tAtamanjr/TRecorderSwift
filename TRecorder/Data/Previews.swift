//
//  Previews.swift
//  TRecorder
//
//  Created by Oleksandr Bolbat on 04.04.2026.
//

import Foundation
import SwiftUI


struct Previews {
    private static let names: [[String]] = [
        ["Jan", "John"],
        ["Jan", "John", "Max"],
        ["Jan", "John", "Max", "Jim"]
    ]
    private static let scores: [[[Int]]] = [
        [
            [9, -5, 13, 2, -5, -5, -5, 6, 12, 9, 7, 10, 6, -5,
             -5, -5, -10, 9, 5, -5, 7, -5, -5, -5, -10, -5,
             -5, 2, 8, 3, -5, 8, 7, 40, 8, 4, -5, -5, -5, 5],
            [5, 4, 1, 5, 7, 10, 8, 6, -5, 8, -5, -5, 14, -5,
             15, -5, 11, -5, -5, 3, 4, -5, 10, -5, 11, -5, 13,
             -5, 6, -5, -5, -5, -10, -5, 7, 50, -5, 11, 10, -5,
             11, 8, -5, 12]
        ],
        [
            [-5, -5, -5, -10, 12, 9, 9, 15, 7, 9, 50, 12, 11, 4,
             3, 25, 0, 13],
            [8, 6, 5, 7, 11, 6, -5, 4, -5, 14, -5, 9, -5, 9],
            [11, 10, 8, 10, 2, -5, -5, -5, 9, -5, 2, 7, 7, 1]
        ],
        [
            [13, 6, -5, -5, -5, 8, 7, 12, 9, 12],
            [12, 10, 4, 6, 11, 15, 13, 25, 3, 2, 10, 8, 8, 5, 7],
            [7, 9, 5, 11, 40, 2, -5, -5, 6],
            [8, 4, 1, 11, 14, 9]
        ]
    ]
    
    static func returnGameSamples() -> [GameHistory] {
        var games: [GameHistory] = []
        var players: [Player] = []
        players.append(Player("Jan", 2))
        players[0].score = scores[0][0]
        players.append(Player("John", 2))
        players[1].score = scores[0][1]
        games.append(GameHistory(players))
        players[0].score = scores[1][0]
        players[1].score = scores[1][1]
        players.append(Player("Max", 2))
        players[2].score = scores[0][2]
        games.append(GameHistory(players))
        players[0].score = scores[2][0]
        players[1].score = scores[2][1]
        players[2].score = scores[2][2]
        players.append(Player("Jim", 2))
        players[3].score = scores[2][3]
        games.append(GameHistory(players))
        return games
    }
    
    static func mainMenuPreview() -> any View {
        let model: Model = Model()
        model.games = returnGameSamples()
        return MainMenuView(model: model)
    }
}

func mainMenuPreview() -> any View {
    return MainMenuView(model: Model())
}

func newGamePreview() -> any View {
    return NewGameView().environmentObject(Model())
}

func gameTurnPreview() -> any View {
    let model: Model = Model()
    model.gameData = GameData(["John", "Max", "Jim", "Dave"])
    return GameTurnView().environmentObject(model)
}

//func gameEndViewPreview() -> any View {
//    let gameData = GameData(["John", "Max", "David"])
//    
//    gameData.players[0].score = [55]
//    gameData.players[1].score = [75]
//    gameData.players[2].score = [65]
//
//    gameData.players[0].dices = 0
//    gameData.players[1].dices = 5
//    gameData.players[2].dices = 1
//    
//    return GameEndView(gameData: gameData).environmentObject(Model())
//}

func gameResultPreview() -> any View {
    let gameHistory: GameHistory = GameHistory([])
    
    gameHistory.players.append(PlayerHistory("John", [15, 5, 7]))
    gameHistory.players.append(PlayerHistory("Max", [10, 1, 6]))
    gameHistory.players.append(PlayerHistory("David", [13, 6, 3]))
    
    return GameResultView(gameHistory: gameHistory).environmentObject(Model())
}

func gameDetailsView() -> any View {
    let gameHistory: GameHistory = GameHistory([])
    
    gameHistory.players.append(PlayerHistory("John", [15, 5, 7]))
    gameHistory.players.append(PlayerHistory("Max", [10, 1, 6]))
    gameHistory.players.append(PlayerHistory("David", [13, 6, 3]))
    
    return GameDetailsView(gameHistory: gameHistory).environmentObject(Model())
}
