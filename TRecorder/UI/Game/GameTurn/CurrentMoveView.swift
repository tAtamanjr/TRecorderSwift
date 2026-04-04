//
//  CurrentMoveView.swift
//  TRecorder
//
//  Created by Oleksandr Bolbat on 28.03.2026.
//

import SwiftUI

struct CurrentMoveView: View {
    @Binding var playerMove: PlayerMove
    
    var body: some View {
        HStack {
            VStack {
                Text("Current Move:").padding(.bottom)
                HStack {
                    Spacer()
                    VStack {
                        Text("Penalty:")
                        Text(playerMove.penalty.description)
                    }
                    Spacer()
                    VStack {
                        Text("Score:")
                        Text(playerMove.score == -1 ? [].description : [playerMove.score].description)
                    }
                    Spacer()
                    VStack {
                        Text("Bonus:")
                        Text(playerMove.bonus == -1 ? [].description : [playerMove.bonus].description)
                    }
                    Spacer()
                }
            }
//            Spacer()
//            VStack() {
//                Text("Penalty: \(playerMove.penalty.description)")
//                Text("Score: \(playerMove.score == -1 ? [].description : [playerMove.score].description)")
//                Text("Bonus: \(playerMove.bonus == -1 ? [].description : [playerMove.bonus].description)")
//            }
//            Spacer()
        }.padding()
    }
}
