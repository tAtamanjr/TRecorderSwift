//
//  Model.swift
//  TRecorder
//
//  Created by Oleksandr Bolbat on 21.03.2026.
//

import SwiftUI
import SwiftData
import Combine

@MainActor
final class Model: ObservableObject {
    // Storage
    let storage: ModelContainer
    private let fetchDescriptor: FetchDescriptor<GameHistory>
    var games: [GameHistory]
        
    // New game
    @Published var newPlayerName: String
    @Published var newGamePlayers: [String]
    
    // Game data
    @Published var gameData: GameData?
    
    //Game turn
    @Published var previousPlayerMove: Int?
    @Published var penalty: [Int]
    @Published var score: Int?
    @Published var bonus: Int?
    @Published var skipTurn: Bool
    
    init() {
        self.storage = {
            do {
                return try ModelContainer(
                    for: GameHistory.self,
                    configurations: ModelConfiguration()
                )
            } catch {
                fatalError("Failed to create container")
            }
        }()
        self.fetchDescriptor = FetchDescriptor<GameHistory>(sortBy: [SortDescriptor(\GameHistory.date)])
        self.games = []
        
        self.newPlayerName = ""
        self.newGamePlayers = []
        
        self.gameData = nil
        
        self.previousPlayerMove = nil
        self.penalty = []
        self.score = nil
        self.bonus = nil
        self.skipTurn = false
        
        self.update()
    }
    
    @Published var rootId: UUID = UUID()
    
    func reset() {
        rootId = UUID()
    }
}

// Storage
extension Model {
    func update() {
        games = {
            do {
                return try storage.mainContext.fetch(fetchDescriptor).reversed()
            } catch {
                return []
            }
        }()
    }
    
    func addGameToStorage(_ game: GameHistory) {
        storage.mainContext.insert(game)
        update()
        reset()
    }
    
    func deleteGame(at offsets: IndexSet) {
        for index in offsets {
            do {
                storage.mainContext.delete(try storage.mainContext.fetch(fetchDescriptor)[index])
                update()
            } catch {
                fatalError("Failed to delete team")
            }
        }
    }
}

// Strings
extension Model {
    static func trimmedString(_ string: String) -> String {
        string.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    static func blankString(_ name: String) -> Bool {
        Model.trimmedString(name).isEmpty
    }
    
    static func currentTimeAndDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: Date())
    }
}

// New game
extension Model {
    func addNewPlayer() {
        newGamePlayers.append(newPlayerName)
        newPlayerName = ""
    }
    
    func cannotAddNewPlayer() -> Bool {
        return Model.blankString(newPlayerName) ||
               newGamePlayers.contains(Model.trimmedString(newPlayerName))
    }
    
    func removePlayer(at offsets: IndexSet) {
        newGamePlayers.remove(atOffsets: offsets)
    }
    
    func cannotStartGame() -> Bool {
        return newGamePlayers.count < 2 || newGamePlayers.count > 4
    }
}

//Game data
extension Model {
    func showResultView() -> Bool {
        return gameData!.playersSkippedMove && gameData!.dicesInThePool == 0
    }
    
    func submitPlayersMove() {
        gameData!.currentPlayerScore += (penalty +
                                         (score != nil ? [score!] : (((gameData!.dicesInThePool - penalty.count) > 0) ? [-10] : [])) +
                                         (bonus != nil ? [bonus!] : []))
        gameData!.currentPlayerDicesCount += (score == nil) ? penalty.count : (penalty.count - 1)
        gameData!.dicesInThePool -= penalty.count
        previousPlayerMove = penalty.count + ((score != nil) ? 1 : 0) + ((bonus != nil) ? 1 : 0)
        resetGameTurnData()
        gameData!.nextPlayer()
    }
    
    func cannotSubmitPlayersMove() -> Bool {
        return (score == nil) && !skipTurn && (penalty.count < 3) && gameData!.dicesInThePool - penalty.count > 0
    }
}

// Game turn
extension Model {
    func resetGameTurnData() {
        penalty = []
        score = nil
        bonus = nil
        skipTurn = false
    }
    
    
}
