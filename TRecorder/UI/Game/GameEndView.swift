//
//  GameEndView.swift
//  TRecorder
//
//  Created by Oleksandr Bolbat on 25.03.2026.
//

//import SwiftUI
//
//struct GameEndView: View {
//    @EnvironmentObject var model: Model
//    
//    @State var gameData: GameData
//    @State var bonus: [Int] = []
//    @State var input: Int = 0
//    @State var done: Bool = false
//    
//    var body: some View {
//        NavigationStack {
//            VStack {
//                HStack {
//                    ForEach(gameData.players) { player in
//                        VStack {
//                            Text(player.name)
//                            Text(player.score.reduce(0, +).description)
//                        }
//                    }.padding()
//                }
//                Spacer()
//                
//                Text(bonus.description).padding()
//                
//                HStack() {
//                    Text("Dice")
//                    TextField("Move", value: $input, format: .number).keyboardType(.numberPad)
//                    Button(action: {
//                        withAnimation {
//                            bonus.append(input)
//                            input = 0
//                        }
//                    }) {
//                        Text("Move")
//                    }
//                    .disabled(input < 0 || input > 15 || bonus.count >= dices() || done)
//                }.padding()
//                
//                Spacer()
//                
//                Button(action: {
//                    withAnimation {
//                        gameData.score += bonus
//                        done = true
//                    }
//                }) {
//                    Text("End")
//                }.disabled(bonus.count < dices() || done)
//                
//                Spacer()
//            }
//            .navigationBarBackButtonHidden(true)
//            .toolbar {
//                ToolbarItem(placement: .principal) {
//                    Text("\(gameData.name)'s Bonus").font(.title)
//                }
//                ToolbarItem(placement: .cancellationAction) {
//                    Button(action: {
//                        bonus.removeLast()
//                    }, label: {
//                        Text("Remove")
//                    })
//                }
//                ToolbarItem(placement: .confirmationAction) {
//                    NavigationLink(destination: {
//                        GameResultView(gameHistory: GameHistory(gameData.players)).environmentObject(model)
//                    }, label: {
//                        Text("Result")
//                        
//                    })
//                    .disabled(!done)
//                }
//            }
//        }
//    }
//    
//    func dices() -> Int {
//        var dices = 0
//        
//        for player in gameData.players { dices += player.dices }
//        
//        return dices
//    }
//}
//
//#Preview {
//    endPreview()
//}
