//
//  GameData.swift
//  TRecorder
//
//  Created by Oleksandr Bolbat on 21.03.2026.
//

import Foundation
import SwiftData

final class GameData {
    var players: [Player]
    var dicesInThePool: Int
    var currentPlayer: Int
    
    var currentPlayerName: String {
        get { return players[currentPlayer].name }
    }
    var currentPlayerScore: [Int] {
        set { players[currentPlayer].score = newValue }
        get { return players[currentPlayer].score }
    }
    var currentPlayerDicesCount: Int {
        set { players[currentPlayer].dicesLeft = newValue }
        get { return players[currentPlayer].dicesLeft }
    }
    var skippedMove: Bool {
        set { players[currentPlayer].skippedTurn = newValue }
        get {
            for player in players {
                if (player.skippedTurn == false) { return false }
            }
            return true
        }
    }
    
    init(_ names: [String]) {
        self.players = []
        self.dicesInThePool = (names.count == 2) ? 38 : (56 - 7 * names.count)
        self.currentPlayer = 0
        
        for name in names {
            players.append(Player(name, names.count))
        }
    }
    
    func nextPlayer() {
        currentPlayer = (currentPlayer + 1) % players.count
    }
}

struct Player: Codable, Identifiable {
    var id: UUID
    var name: String
    var dicesLeft: Int
    var score: [Int]
    var skippedTurn: Bool
    
    init(_ name: String, _ playersAmount: Int) {
        self.id = UUID()
        self.name = name
        self.dicesLeft = (playersAmount == 2) ? 9 : 7
        self.score = []
        self.skippedTurn = false
    }
}
