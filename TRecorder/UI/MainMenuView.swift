//
//  MainMenuView.swift
//  TRecorder
//
//  Created by Oleksandr Bolbat on 21.03.2026.
//

import SwiftUI

struct MainMenuView: View {
    @ObservedObject var model: Model
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Spacer()
                
                NavigationLink(destination: {
                    NewGameView().environmentObject(Model())
                }, label: {
                    Text("Start game").font(.title2)
                })
                
                Spacer()
                
                NavigationLink(destination: {
                    HistoryView().environmentObject(Model())
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
