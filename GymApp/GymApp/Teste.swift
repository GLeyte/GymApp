//
//  Teste.swift
//  GymApp
//
//  Created by Gabriel Leite on 02/11/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        List {
            ForEach(Musculo.allCases) {value in
                Section {
                    ForEach(0..<2) {
                        Text("Dynamic row \($0)")
                    }
                } header: {
                    Text(value.rawValue)
                }
            }
        }
    }
}
#Preview {
    ContentView()
}
