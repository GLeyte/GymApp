//
//  InicialExercisesView.swift
//  GymApp
//
//  Created by Gabriel Leite on 02/11/23.
//

import SwiftUI
import SwiftData

struct InicialExercisesView: View {
    
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var stackPath: PathType
    @Query private var exercises: [Exercise]
    
    
    var body: some View {
        
        List {
            ForEach(Musculo.allCases) { musculo in
                Section {
                    ForEach(exercises.filter{$0.musculo == musculo}, id: \.self) { exercise in
                        NavigationLink(value: exercises.firstIndex(of:exercise)) {
                            Text("\(exercise.nome)")
                        }
                    }
                    .onDelete(perform: deleteExercises)
                } header: {
                    Text(musculo.rawValue)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItem {
                Button {
                    stackPath.path.append(-1)
                } label: {
                    Label("Add Item", systemImage: "plus")
                }
            }
        }
        .navigationDestination(for: Int.self) { value in
            if value == -1 {
                NewExerciseView()
            } else {
                Text ("ANOTHER SCREEN: \(value)")
            }
        }
        
    }
    
    private func addExercises() {
        withAnimation {
            let newItem = Exercise(nome: "Huhu", musculo: .ombro, carga: [Carga(peso: 5.5, data: .now)], series: 5, repeticoes: "haha")
            modelContext.insert(newItem)
        }
    }
    
    private func deleteExercises(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(exercises[index])
            }
        }
    }
}


extension InicialExercisesView {
    
}

#Preview {
    InicialExercisesView()
        .modelContainer(for: Exercise.self, inMemory: true)
}
