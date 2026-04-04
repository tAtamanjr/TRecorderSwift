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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    HistoryView().environmentObject(Model())
}
