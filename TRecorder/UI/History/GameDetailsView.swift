//
//  GameDetailsView.swift
//  TRecorder
//
//  Created by Oleksandr Bolbat on 06.04.2026.
//

import SwiftUI

struct GameDetailsView: View {
    @EnvironmentObject var model: Model
    @Environment(\.dismiss) var dismiss
    
    let gameHistory: GameHistory
    
    var body: some View {
        NavigationStack(path: $model.path) {
            VStack {
                ForEach(gameHistory.players) { player in
                    PlayerData(player: player)
                }
                Spacer()
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Game")
                        .font(.title)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Text("Back")
                    })
                }
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .GameDetails(let game):
                    GameDetailsView(gameHistory: game)
                        .environmentObject(model)
                default:
                    Text("Uncorrect view")
                }
            }
        }
    }
}

#Preview {
    Previews.gameDetailsPreview()
}
