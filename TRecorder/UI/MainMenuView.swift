//
//  MainMenuView.swift
//  TRecorder
//
//  Created by Oleksandr Bolbat on 21.03.2026.
//

import SwiftUI
import SwiftData

struct MainMenuView: View {
    @ObservedObject var model: Model
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Spacer()
                
                NavigationLink(destination: {
                    NewGameView().environmentObject(model)
                }, label: {
                    Text("Start game").font(.title2)
                })
                
                Spacer()
                
                NavigationLink(destination: {
                    HistoryView().environmentObject(model)
                }, label: {
                    Text("History").font(.title2)
                })
                
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Main Menu").font(.title)
                }
            }
        }.id(model.rootId)
    }
}

#Preview {
    mainMenuPreview()
}
