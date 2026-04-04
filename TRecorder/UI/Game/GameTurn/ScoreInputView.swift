//
//  ScoreInputView.swift
//  TRecorder
//
//  Created by Oleksandr Bolbat on 28.03.2026.
//

import SwiftUI

struct ScoreInputView: View {
    @Binding var score: Int
    @Binding var skipMove: Bool
    @State var input: Int = 0
    
    var body: some View {
        HStack() {
            Text("Dice")
            TextField("Move", value: $input, format: .number).keyboardType(.numberPad)
            Button(action: {
                withAnimation {
                    score = input
                    skipMove = false
                }
            }) {
                Text("Move")
            }
            .disabled(input < 0 || input > 15)
        }.padding()
    }
}
