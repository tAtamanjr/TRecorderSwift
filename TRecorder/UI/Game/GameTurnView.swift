//
//  GameTurnView.swift
//  TRecorder
//
//  Created by Oleksandr Bolbat on 21.03.2026.
//

import SwiftUI

struct GameTurnView: View {
    @EnvironmentObject var model: Model
    
//    @State var gameData: GameData
//    @State var playerMove: PlayerMove = PlayerMove()
//    @State var input: Int = 0
    
    var body: some View {
        NavigationStack {
            VStack {
                playersDataView
                
                Spacer()
                
                currentMoveView
                
                Spacer()
                
                scoreInputView
                
                poolingView
                
                bonusesView
                
                Spacer()
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("\(model.gameData!.currentPlayerName)'s Turn").font(.title)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: {
                        model.resetGameTurnData()
                    }, label: {
                        Text("Reset")
                    })
                }
                ToolbarItem(placement: .confirmationAction) {
                    if (model.showResultView()) {
                        NavigationLink(destination: {
                            GameResultView(gameHistory: GameHistory(model.gameData!.players)).environmentObject(model)
                        }, label: {
                            Text("End")
                        })
                    } else {
                        Button(action: {
                            withAnimation {
                                model.submitMove()
                            }
                        }) {
                            Text("Next")
                        }.disabled(model.cannotSubmitPlayersMove())
                    }
                }
            }
        }
    }
    
    private var playersDataView: some View {
        VStack {
            HStack {
                ForEach(model.gameData!.players) { player in
                    VStack {
                        Text(player.name).padding(.bottom, 2).font(.title3)
                        player.name != model.gameData!.currentPlayerName
                        ? Text("Dices: \(player.dicesLeft)")
                        : Text("Dices: \(player.dicesLeft + model.penalty.count - (model.score != nil ? 1 : 0))")
                        Text("Score:")
                        Text(player.score.reduce(0, +).description)
                    }.padding(4)
                }
            }.padding()
            Text("Pool: \(model.gameData!.dicesInThePool - model.penalty.count)").font(.title3)
        }.padding()
    }
    
    private var currentMoveView: some View {
        HStack {
            VStack {
                Text("Current Move:").font(.title3).padding(.bottom)
                HStack {
                    Spacer()
                    VStack {
                        Text("Penalty:")
                        Text(model.penalty.description)
                    }
                    Spacer()
                    VStack {
                        Text("Score:")
                        Text(model.score == nil ? [].description : [model.score!].description)
                    }
                    Spacer()
                    VStack {
                        Text("Bonus:")
                        Text(model.bonus == nil ? [].description : [model.bonus!].description)
                    }
                    Spacer()
                }
            }
        }.padding()
    }
    
    var scoreInputView: some View {
        HStack() {
            Text("Dice:").font(.title3)
            TextField("Move", value: $model.input, format: .number).keyboardType(.numberPad).font(.title3)
            Button(action: {
                withAnimation {
                    model.submitDice()
                }
            }) {
                Image(systemName: "plus").font(.title3)
            }
            .disabled(model.cannotSubmitDice())
        }.padding().disabled(model.gameData!.skippedMove && model.gameData!.dicesInThePool == 0)
    }
    
    private var poolingView: some View {
        HStack {
            if (model.canTakeDice) {
                Button(action: {
                    withAnimation {
                        model.poolDice()
                    }
                }) {
                    Text("Take dice").font(.title3)
                }.disabled(model.penalty.count >= 3)
            } else {
                Button(action: {
                    withAnimation {
                        model.skipTurn = true
                        model.gameData!.skippedMove = true
                    }
                }) {
                    Text("Skip")
                }.disabled(model.skipTurn)
            }
        }.disabled(model.gameData!.skippedMove && !(model.gameData!.dicesInThePool - model.penalty.count > 0))
    }
    
    private var bonusesView: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    withAnimation {
                        model.bonus = 40
                    }
                }) {
                    Text("Bridge").font(.title3)
                }.disabled(model.score == nil || model.bonus! == 40)
                Spacer()
                Button(action: {
                    withAnimation {
                        model.bonus = 50
                    }
                }) {
                    Text("Hexagon").font(.title3)
                }.disabled(model.score == nil || model.bonus! == 50)
                Spacer()
            }.padding(.bottom)
            HStack {
                Spacer()
                Button(action: {
                    withAnimation {
                        model.bonus = 60
                    }
                }) {
                    Text("Double\nHexagon").font(.title3)
                }.disabled(model.score == nil || model.bonus! == 60)
                Spacer()
                Button(action: {
                    withAnimation {
                        model.bonus = 70
                    }
                }) {
                    Text("Triple\nHexagon").font(.title3)
                }.disabled(model.score == nil || model.bonus! == 70)
                Spacer()
            }
        }.padding().disabled(model.gameData!.skippedMove && model.score == nil)
    }
}

#Preview {
    gameTurnPreview()
}
