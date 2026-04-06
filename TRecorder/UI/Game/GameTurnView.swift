//
//  GameTurnView.swift
//  TRecorder
//
//  Created by Oleksandr Bolbat on 21.03.2026.
//

import SwiftUI

struct GameTurnView: View {
    @EnvironmentObject var model: Model
    
    @State var gameData: GameData
    @State var playerMove: PlayerMove = PlayerMove()
    @State var input: Int = 0
    @State private var isPushed: Bool = false
    
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
                    Text("\(gameData.name)'s Turn").font(.title)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: {
                        playerMove.reset()
                    }, label: {
                        Text("Reset")
                    })
                }
                ToolbarItem(placement: .confirmationAction) {
                    if (gameData.skip && gameData.pool == 0) {
                        NavigationLink(destination: {
                            ResultView(gameHistory: GameHistory(gameData.players)).environmentObject(model)
                        }, label: {
                            Text("End")
                        })
                    } else {
                        Button(action: {
                            withAnimation {
                                gameData.score += playerMove.getScoreChange(gameData.pool)
                                gameData.dices += playerMove.diceChange
                                gameData.pool += playerMove.poolChange
                                playerMove.reset()
                                gameData.nextPlayer()
                            }
                        }) {
                            Text("Next")
                        }.disabled(playerMove.endTurn && gameData.pool - playerMove.penalty.count > 0)
                    }
                }
            }
        }
    }
    
    private var playersDataView: some View {
        VStack {
            HStack {
                ForEach(gameData.players) { player in
                    VStack {
                        Text(player.name).padding(.bottom, 2).font(.title3)
                        player.name != gameData.name
                        ? Text("Dices: \(player.dices)")
                        : Text("Dices: \(player.dices + playerMove.penalty.count - (playerMove.score != -1 ? 1 : 0))")
                        Text("Score:")
                        Text(player.score.reduce(0, +).description)
                    }.padding(4)
                }
            }.padding()
            Text("Pool: \(gameData.pool - playerMove.penalty.count)").font(.title3)
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
        }.padding()
    }
    
    var scoreInputView: some View {
        HStack() {
            Text("Dice:").font(.title3)
            TextField("Move", value: $input, format: .number).keyboardType(.numberPad).font(.title3)
            Button(action: {
                withAnimation {
                    playerMove.score = input
                    gameData.skip = false
                }
            }) {
                Image(systemName: "plus").font(.title3)
            }
            .disabled(input < 0 || input > 15)
        }.padding().disabled(gameData.skip && gameData.pool == 0)
    }
    
    private var poolingView: some View {
        HStack {
            if ((gameData.pool - playerMove.penalty.count) > 0) {
                Button(action: {
                    withAnimation {
                        playerMove.penalty.append(-5)
                        if (playerMove.penalty.count == 3) { gameData.skip = true }
                    }
                }) {
                    Text("Take dice").font(.title3)
                }.disabled(playerMove.penalty.count >= 3)
            } else {
                Button(action: {
                    withAnimation {
                        playerMove.skip = true
                        gameData.skip = true
                    }
                }) {
                    Text("Skip")
                }.disabled(playerMove.skip)
            }
        }.disabled(gameData.skip && !(gameData.pool - playerMove.penalty.count > 0))
    }
    
    private var bonusesView: some View {
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
        }.padding().disabled(gameData.skip && playerMove.score == -1)
    }
}

#Preview {
    gameTurnPreview()
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
                Text("Bridge").font(.title3)
            case 50:
                Text("Hexagon").font(.title3)
            case 60:
                Text("Double\nHexagon").font(.title3)
            case 70:
                Text("Triple\nHexagon").font(.title3)
            default:
                Text("None").font(.title3)
            }
        }.disabled(playerMove.score == -1 || playerMove.bonus == amount)
    }
}
