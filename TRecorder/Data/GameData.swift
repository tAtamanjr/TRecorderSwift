//
//  GameData.swift
//  TRecorder
//
//  Created by Oleksandr Bolbat on 21.03.2026.
//

import Foundation
import SwiftData

@Model
class GameData {
    var players: [Player]
    var name: String {
        get { return players[playerToMove].name }
    }
    var dices: Int {
        set { players[playerToMove].dices = newValue }
        get { return players[playerToMove].dices }
    }
    var score: [Int] {
        set { players[playerToMove].score = newValue }
        get { return players[playerToMove].score }
    }
    var skip: Bool {
        set { players[playerToMove].skip = newValue }
        get {
            for player in players {
                if (player.skip == false) { return false }
            }
            return true
        }
    }
    var pool: Int
    var playerToMove: Int
    
    init(_ names: [String]) {
        self.players = []
        self.pool = (names.count == 2) ? 38 : (56 - 7 * names.count)
        self.playerToMove = 0
        
        for name in names {
            players.append(Player(name, names.count))
        }
    }
    
    func nextPlayer() {
        playerToMove = (playerToMove + 1) % players.count
    }
}

struct Player: Codable, Identifiable {
    var id: UUID
    var name: String
    var dices: Int
    var score: [Int]
    var skip: Bool
    
    init(_ name: String, _ playersAmount: Int) {
        self.id = UUID()
        self.name = name
        self.dices = (playersAmount == 2) ? 9 : 7
        self.score = []
        self.skip = false
    }
}
