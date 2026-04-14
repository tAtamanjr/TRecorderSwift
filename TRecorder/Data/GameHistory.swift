//
//  GameHistory.swift
//  TRecorder
//
//  Created by Oleksandr Bolbat on 29.03.2026.
//


import Foundation
import SwiftData

@Model
final class GameHistory {
    var id: UUID
    var date: Date
    var players: [PlayerHistory]
    
    @MainActor
    init(_ players: [Player]) {
        self.id = UUID()
        self.date = Date.now
        self.players = []
        for player in players {
            self.players.append(PlayerHistory(player.name, player.score))
        }
        self.players.sort { $0.score.reduce(0, +) > $1.score.reduce(0, +) }
    }
}

@Model
final class PlayerHistory {
    var id: UUID
    var name: String
    var score: [Int]
    
    init(_ name: String, _ score: [Int]) {
        self.id = UUID()
        self.name = name
        self.score = score
    }
}
