//
//  HistoryView.swift
//  TRecorder
//
//  Created by Oleksandr Bolbat on 21.03.2026.
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var model: Model
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack(path: $model.path) {
            VStack {
                if model.games.isEmpty {
                    Spacer()
                    Text("No games played")
                        .font(.title)
                        .bold()
                    Spacer()
                } else {
                    List {
                        ForEach(model.games) { game in
//                            NavigationLink(destination: {
//                                GameHistoryView(gameHistory: game).environmentObject(model)
//                            }, label: {
//                                GameHistoryPreview(game: game)
//                            })
                            Button(action: {
                                model.route(Route.GameDetails(game))
                            }) {
                                GameHistoryPreview(game: game)
                            }
                        }
                        .onDelete(perform: model.deleteGameFromContainer(at:))
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Games").font(.title)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Text("Back")
                    })
                }
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .History:
                    HistoryView().environmentObject(model)
                case .GameDetails(let game):
                    GameDetailsView(gameHistory: game).environmentObject(model)
                default:
                    Text("Default")
                }
            }
        }
    }
}

#Preview {
//    HistoryView().environmentObject(Model())
}

struct GameHistoryPreview: View {
    var game: GameHistory
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(Model.dateToString(game.date)).font(.title2)
            
            HStack {
                Text("\(game.players.count)")
                if game.players.count == 2 {
                    Image(systemName: "person.2")
                } else {
                    Image(systemName: "person.line.dotted.person")
                }
                
                Spacer()
                
                Text(game.players[0].name)
                Image(systemName: "flag.and.flag.filled.crossed")
            }
        }
    }
}
