//
//  HistoryView.swift
//  TRecorder
//
//  Created by Oleksandr Bolbat on 21.03.2026.
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var model: Model
    
    var body: some View {
        NavigationStack {
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
                            NavigationLink(destination: {
                                GameHistoryView(gameHistory: game).environmentObject(model)
                            }, label: {
                                GameHistoryPreview(game: game)
                            })
                        }
                        .onDelete(perform: model.deleteGame)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Games").font(.title)
                }
            }
        }
    }
}

#Preview {
    HistoryView().environmentObject(Model())
}

struct GameHistoryPreview: View {
    var game: GameHistory
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(game.date).font(.title2)
            
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
