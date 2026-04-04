//
//  PlayerMove.swift
//  TRecorder
//
//  Created by Oleksandr Bolbat on 29.03.2026.
//

import Foundation

struct PlayerMove {
    var penalty: [Int]
    var score: Int
    var bonus: Int
    var skip: Bool
    
    var diceChange: Int {
        get { return (score == -1) ? penalty.count : (-1 + penalty.count) }
    }
    
    var poolChange: Int {
        get { return -penalty.count }
    }
    
    var endTurn: Bool {
        get { return (score == -1) && !skip && (penalty.count < 3) }
    }
    
    init() {
        self.penalty = []
        self.score = -1
        self.bonus = -1
        self.skip = false
    }
    
    mutating func reset() {
        penalty = []
        score = -1
        bonus = -1
        skip = false
    }
    
    func getScoreChange(_ pool: Int) -> [Int] {
        return (
            penalty +
            (score != -1 ? [score] : (((pool - penalty.count) > 0) ? [-10] : [])) +
            (bonus != -1 ? [bonus] : [])
        )
    }
}
