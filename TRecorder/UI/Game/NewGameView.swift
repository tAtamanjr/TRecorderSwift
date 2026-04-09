//
//  NewGameView.swift
//  TRecorder
//
//  Created by Oleksandr Bolbat on 21.03.2026.
//

import SwiftUI

struct NewGameView: View {
    @EnvironmentObject var model: Model
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            List {
                Section("Players") {
                    ForEach(model.newGamePlayers, id: \.self) { player in
                        Text(player)
                    }.onDelete(perform: model.removePlayer)
                    if (model.newGamePlayers.count < 4) {
                        HStack {
                            TextField("Name", text: $model.newPlayerName).disableAutocorrection(true)
                            
                            Spacer()
                            
                            Button(action: {
                                withAnimation {
                                    model.addNewPlayer()
                                }
                            }, label: {
                                Image(systemName: "plus")
                            }).disabled(model.cannotAddNewPlayer())
                        }
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("New Game").font(.title)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Text("Cancel")
                    })
                }
                ToolbarItem(placement: .confirmationAction) {
                    NavigationLink(destination: {
                        GameTurnView(gameData: GameData(model.newGamePlayers)).environmentObject(model)
                    }, label: {
                        Text("Start")
                    }).disabled(model.cannotStartGame())
                }
            }
        }
    }
}

#Preview {
    newGamePreview()
}
