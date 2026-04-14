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
    // UI
    @Published var path: NavigationPath
    
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
    @Published var input: Int?
    @Published var bonus: Int?
    @Published var skipTurn: Bool
    
    init() {
        self.path = NavigationPath()
        
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
        self.input = nil
        self.bonus = nil
        self.skipTurn = false
        
//        self.loadFromStorage()
    }
}

//UI
extension Model {
    func route(_ to: Route) {
        path.append(to)
    }
    
    func clearPath() {
        path = NavigationPath()
    }
}

// Storage
extension Model {
    func loadFromStorage() {
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
        loadFromStorage()
        clearPath()
    }
    
    func deleteGameFromStorage(at offsets: IndexSet) {
        for index in offsets {
            do {
                storage.mainContext.delete(try storage.mainContext.fetch(fetchDescriptor)[index])
                loadFromStorage()
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
    
    static func dateToString(_ date: Date) -> String {
        return date.formatted(.iso8601.year().month().day())
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
        return gameData!.skippedMove && gameData!.dicesInThePool == 0
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
    
    var canTakeDice: Bool { get { return (gameData!.dicesInThePool - penalty.count) > 0 } }
    
    func poolDice() {
        penalty.append(-5)
        if (penalty.count == 3) { skipTurn = true }
    }
    
    func submitDice() {
        score = input!
        gameData!.skippedMove = false
    }
    
    func cannotSubmitDice() -> Bool {
        return (input == nil || input! < 0 || input! > 15)
    }
    
    func submitMove() {
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
