//
//  MainView.swift
//  GymApp
//
//  Created by Gabriel Leite on 02/11/23.
//

import SwiftUI

struct MainView: View {
    
    @StateObject private var stackPath = PathType()
    
    var body: some View {
        
        TabView {
            NavigationStack(path: $stackPath.path) {
                InicialExercisesView()
                    .navigationTitle("Treino")
                
            }
            .environmentObject(stackPath)
            .tabItem {
                Label("Treino", systemImage: "dumbbell.fill")
            }
            
            NavigationStack(path: $stackPath.path) {
                InicialExercisesView()
                    .navigationTitle("Exercícios")
                
            }
            .environmentObject(stackPath)
            .tabItem {
                Label("Exercícios", systemImage: "figure.strengthtraining.traditional")
            }
        }
    }
}

#Preview {
    MainView()
}
