//
//  Model.swift
//  TRecorder
//
//  Created by Oleksandr Bolbat on 21.03.2026.
//

import SwiftData
import SwiftUI
import Combine

@MainActor
class Model: ObservableObject {
    var objectWillChange: ObservableObjectPublisher
    let storage: ModelContainer
    private let fetchDescriptor: FetchDescriptor<GameHistory>
    var teams: [GameHistory]
    
    @State static var gameData: GameData = GameData([])
    @State static var playerMove: PlayerMove = PlayerMove()
    
    init() {
        self.objectWillChange = ObservableObjectPublisher()
        
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
        self.teams = []
        self.update()
    }
    
    func update() {
        teams = {
            do {
                return try storage.mainContext.fetch(fetchDescriptor)
            } catch {
                return []
            }
        }()
    }
    
    func addTeamToStorage(_ game: GameHistory) {
        storage.mainContext.insert(game)
        update()
        reset()
    }
    
    func deleteTeam(at offsets: IndexSet) {
        for index in offsets {
            do {
                storage.mainContext.delete(try storage.mainContext.fetch(fetchDescriptor)[index])
            } catch {
                fatalError("Failed to delete team")
            }
        }
    }
    
    @Published var rootId: UUID = UUID()
    private var resetter: Bool = true {
        didSet {
            rootId = UUID()
        }
    }
    
    func reset() {
        resetter.toggle()
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
