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
    
    @State var name: String = ""
    @State var players: [String] = []
    
    var body: some View {
        NavigationStack {
            List {
                Section("Players") {
                    ForEach(players, id: \.self) { player in
                        Text(player)
                    }
                    .onDelete(perform: removePlayer)
                    if (players.count < 4) {
                        HStack {
                            TextField("Name", text: $name).disableAutocorrection(true)
                            
                            Spacer()
                            
                            Button(action: {
                                withAnimation {
                                    players.append(name)
                                    name = ""
                                }
                            }, label: {
                                Image(systemName: "plus")
                            }).disabled(
                                Model.blankString(name) ||
                                players.contains(Model.trimmedString(name))
                            )
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
                        GameTurnView(gameData: GameData(players)).environmentObject(model)
                    }, label: {
                        Text("Start")
                    }).disabled(players.count < 2 || players.count > 4)
                }
            }
        }
    }
    
    func removePlayer(at offsets: IndexSet) {
        players.remove(atOffsets: offsets)
    }
}

#Preview {
    newGamePreview()
}
