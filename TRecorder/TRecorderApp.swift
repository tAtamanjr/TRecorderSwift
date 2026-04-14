//
//  TRecorderApp.swift
//  TRecorder
//
//  Created by Oleksandr Bolbat on 18.03.2026.
//

import SwiftUI
import SwiftData

@main
struct TRecorderApp: App {
    let container: ModelContainer
    @StateObject private var model: Model

    init() {
        do {
            let container = try ModelContainer(
                for: GameHistory.self,
                configurations: ModelConfiguration()
            )
            self.container = container
            _model = StateObject(wrappedValue: Model(container))
        } catch {
            fatalError("Failed to create app container: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            MainMenuView().environmentObject(model)
        }.modelContainer(container)
    }
}
