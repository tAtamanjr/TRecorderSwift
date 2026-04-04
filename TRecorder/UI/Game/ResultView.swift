//
//  ResultView.swift
//  TRecorder
//
//  Created by Oleksandr Bolbat on 29.03.2026.
//

import SwiftUI

struct ResultView: View {
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
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Result").font(.title)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: {
                        withAnimation {
                            model.reset()
                        }
                    }) {
                        Text("End")
                    }
                }
            }
        }
    }
}

#Preview {
    resultPreview()
}

struct PlayerData: View {
    let player: PlayerHistory
    
    var body: some View {
        VStack {
            HStack {
                Text("Name: " + player.name)
                Spacer()
            }
            HStack {
                Text("Score: " + player.score.reduce(0, +).description)
                Spacer()
            }
        }.padding()
    }
}
