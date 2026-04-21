//
//  GameEndView.swift
//  TRecorder
//
//  Created by Oleksandr Bolbat on 25.03.2026.
//

import SwiftUI

struct GameEndView: View {
    @EnvironmentObject var model: Model
    
    @State var gameData: GameData
    @State var bonus: [Int] = []
    @State var input: Int = 0
    @State var done: Bool = false
    
    var body: some View {
        NavigationStack(path: $model.path) {
            VStack {
                HStack {
                    ForEach(gameData.players) { player in
                        VStack {
                            Text(player.name)
                            Text(player.score.reduce(0, +).description)
                        }
                    }.padding()
                }
                Spacer()
                
                Text(bonus.description).padding()
                
                HStack() {
                    Text("Dice")
                    TextField("Move", value: $input, format: .number).keyboardType(.numberPad)
                    Button(action: {
                        withAnimation {
                            bonus.append(input)
                            input = 0
                        }
                    }) {
                        Text("Move")
                    }
                    .disabled(input < 0 || input > 15 || bonus.count >= dices() || done)
                }.padding()
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        model.gameData!.currentPlayerScore += bonus
                        done = true
                    }
                }) {
                    Text("End")
                }.disabled(bonus.count < dices() || done)
                
                Spacer()
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("\(model.gameData!.currentPlayerName)'s Bonus")
                        .font(.title)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: {
                        bonus.removeLast()
                    }, label: {
                        Text("Remove")
                    })
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: {
                        model.route(.GameResult(GameHistory(gameData.players)))
                    }, label: {
                        Text("Result")
                        
                    })
                    .disabled(!done)
                }
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .GameEnd:
                    GameEndView(gameData: gameData)
                        .environmentObject(model)
                case .GameResult(let gameHistory):
                    GameResultView(gameHistory: gameHistory)
                        .environmentObject(model)
                default:
                    Text("Uncorrect view")
                }
            }
        }
    }
    
    func dices() -> Int {
        var dices = 0
        
        for player in gameData.players { dices += player.dicesLeft }
        
        return dices
    }
}

#Preview {
    Previews.gameEndPreview()
}
