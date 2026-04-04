//
//  PoolingView.swift
//  TRecorder
//
//  Created by Oleksandr Bolbat on 28.03.2026.
//

import SwiftUI

struct PoolingView: View {
    @Binding var pool: Int
    @Binding var skipMove: Bool
    @Binding var playerMove: PlayerMove
    
    var body: some View {
        if ((pool - playerMove.penalty.count) > 0) {
            Button(action: {
                withAnimation {
                    playerMove.penalty.append(-5)
                    if (playerMove.penalty.count == 3) { skipMove = true }
                }
            }) {
                Text("Take dice")
            }.disabled(playerMove.penalty.count >= 3)
        } else {
            Button(action: {
                withAnimation {
                    playerMove.skip = true
                    skipMove = true
                }
            }) {
                Text("Skip")
            }.disabled(playerMove.skip)
        }
    }
}
