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
    @State private var isPushed: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                PlayersDataView(
                    players: $gameData.players,
                    penalty: $playerMove.penalty,
                    name: gameData.name
                )
                Text("Pool: \(gameData.pool - playerMove.penalty.count)")
                
                Spacer()
                
                CurrentMoveView(playerMove: $playerMove)
                
                Spacer()
                
                ScoreInputView(score: $playerMove.score, skipMove: $gameData.skip)
                
                PoolingView(
                    pool: $gameData.pool,
                    skipMove: $gameData.skip,
                    playerMove: $playerMove
                    
                ).disabled(gameData.skip && gameData.pool == 0)
                
                BonusesView(playerMove: $playerMove).disabled(gameData.skip && playerMove.score == -1)
                
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
                    } else if (gameData.players[gameData.playerToMove].dices > 0) {
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
                        }.disabled(playerMove.endTurn)
                    } else {
                        NavigationLink(destination: EndView(gameData: gameData).environmentObject(model), isActive: $isPushed, label: {
                            Button {
                                gameData.score += playerMove.getScoreChange(gameData.pool)
                                gameData.dices += playerMove.diceChange
                                gameData.pool += playerMove.poolChange
                                
                                isPushed = true
                            } label: {
                                Text("End")
                            }
                        })
                    }
                }
            }
        }
    }
}

#Preview {
    gameTurnPreview()
}
