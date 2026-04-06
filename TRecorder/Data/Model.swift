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
class Model: ObservableObject {
    let storage: ModelContainer
    private let fetchDescriptor: FetchDescriptor<GameHistory>
        var games: [GameHistory]
        
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
        self.update()
    }
    
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
    
    @Published var rootId: UUID = UUID()
    
    func reset() {
        rootId = UUID()
    }
    
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
