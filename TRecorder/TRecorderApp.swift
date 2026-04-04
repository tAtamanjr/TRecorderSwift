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
    var body: some Scene {
        WindowGroup {
            MainMenuView(model: Model())
        }.modelContainer(for: GameHistory.self)
    }
}
