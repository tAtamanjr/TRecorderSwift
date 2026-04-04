//
//  BonusesView.swift
//  TRecorder
//
//  Created by Oleksandr Bolbat on 28.03.2026.
//

import SwiftUI

struct BonusesView: View {
    @Binding var playerMove: PlayerMove
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                BonusButton(playerMove: $playerMove, amount: 40)
                Spacer()
                BonusButton(playerMove: $playerMove, amount: 50)
                Spacer()
            }.padding(.bottom)
            HStack {
                Spacer()
                BonusButton(playerMove: $playerMove, amount: 60)
                Spacer()
                BonusButton(playerMove: $playerMove, amount: 70)
                Spacer()
            }
        }.padding()
    }
}

struct BonusButton: View {
    @Binding var playerMove: PlayerMove
    let amount: Int
    
    var body: some View {
        Button(action: {
            withAnimation {
                playerMove.bonus = amount
            }
        }) {
            switch(amount) {
            case 40:
                Text("Bridge")
            case 50:
                Text("Hexagon")
            case 60:
                Text("Double\nHexagon")
            case 70:
                Text("Triple\nHexagon")
            default:
                Text("None")
            }
        }.disabled(playerMove.score == -1 || playerMove.bonus == amount)
    }
}
