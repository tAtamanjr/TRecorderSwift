//
//  MainMenuView.swift
//  TRecorder
//
//  Created by Oleksandr Bolbat on 21.03.2026.
//

import SwiftUI
import SwiftData

struct MainMenuView: View {
    @EnvironmentObject var model: Model
    
    var body: some View {
        NavigationStack(path: $model.path) {
            VStack {
                Spacer()
                Spacer()
                
//                NavigationLink(destination: {
//                    NewGameView().environmentObject(model)
//                }, label: {
//                    Text("Start game").font(.title2)
//                })
                Button(action: {
                    model.route(Route.NewGame)
//                    model.route("NewGame")
                }) {
                    Text("Start game").font(.title2)
                }
                
                Spacer()
                
//                NavigationLink(destination: {
//                    HistoryView().environmentObject(model)
//                }, label: {
//                    Text("History").font(.title2)
//                })
                Button(action: {
                    model.route(Route.History)
//                    model.route("History")
                }) {
                    Text("History").font(.title2)
                }
                
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Main Menu").font(.title)
                }
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .NewGame:
                    NewGameView().environmentObject(model)
                case .History:
                    HistoryView().environmentObject(model)
                default:
                    Text("Default")
                }
            }
        }
    }
}

#Preview {
    Previews.mainMenuPreview()
}
