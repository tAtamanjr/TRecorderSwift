//
//  GameHistoryView.swift
//  TRecorder
//
//  Created by Oleksandr Bolbat on 06.04.2026.
//

import SwiftUI

struct GameHistoryView: View {
    @EnvironmentObject var model: Model
    
    let gameHistory: GameHistory
    
    var body: some View {
        NavigationStack {
            VStack {
                ForEach(gameHistory.players) { player in
                    PlayerData(player: player)
                }
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Game").font(.title)
                }
            }
        }
    }
}

#Preview {
    gameHistoryPreview()
}
