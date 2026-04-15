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
        NavigationStack(path: $model.path) {
            List {
                Section("Players") {
                    ForEach(model.newGamePlayers, id: \.self) { player in
                        Text(player)
                    }
                    .onDelete(perform: model.removePlayer)
                    if (model.newGamePlayers.count < 4) {
                        HStack {
                            TextField("Name", text: $model.newPlayerName)
                                .disableAutocorrection(true)
                            
                            Spacer()
                            
                            Button(action: {
                                withAnimation {
                                    model.addNewPlayer()
                                }
                            }, label: {
                                Image(systemName: "plus")
                            })
                            .disabled(model.cannotAddNewPlayer())
                        }
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("New Game")
                        .font(.title)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Text("Cancel")
                    })
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: {
                        model.route(.GameTurn)
                    }, label: {
                        Text("Start")
                    })
                    .disabled(model.cannotStartGame())
                }
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .NewGame:
                    NewGameView()
                        .environmentObject(model)
                case .GameTurn:
                    GameTurnView()
                        .environmentObject(model)
                default:
                    Text("Uncorrect view")
                }
            }
        }
    }
}

#Preview {
    Previews.newGamePreview()
}
