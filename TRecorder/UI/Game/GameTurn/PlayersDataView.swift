//
//  PlayersDataView.swift
//  TRecorder
//
//  Created by Oleksandr Bolbat on 28.03.2026.
//

import SwiftUI

struct PlayersDataView: View {
    @Binding var players: [Player]
    @Binding var penalty: [Int]
    var name: String
    
    var body: some View {
        HStack {
            Spacer()
            ForEach(players) { player in
                VStack {
                    Text(player.name).padding(.bottom)
                    (player.name != name) ? Text("Dices: \(player.dices)") : Text("Dices: \(player.dices + penalty.count)")
                    Text("Score: \(player.score.reduce(0, +))")
                    Text(player.skip ? "Passed" : "Moved")
                }
                Spacer()
            }
        }.padding()
    }
}
