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
    @Query(sort: \Exercise.nome) private var exercises: [Exercise]
    
    
    var body: some View {
        
        List {
            ForEach(Musculo.allCases) { musculo in
                Section {
                    ForEach(exercises.filter{$0.musculo == musculo}, id: \.self) { exercise in
                        NavigationLink(value: exercise.id) {
                            HStack {
                                Text("\(exercise.nome)")
                                    .bold()
                                Spacer()
                                Text("\(exercise.ultimaCarga, specifier: "%.1f")")
                                    .bold()
                            }
                        }
                    }
                    .onDelete {self.deleteExercises(at: $0, musculo: musculo)}
                } header: {
                    Text(musculo.localizedName)
                }
            }
        }
        .toolbar {
            NavigationLink(value: "Adicionar") {
                Image(systemName: "plus")
            }
        }
        .navigationDestination(for: String.self) { value in
            if value == "Adicionar" {
                NewExerciseView()
            } else {
                if exercises.contains(where: {$0.id == value}) {
                    ExerciseStatusView(exercise: exercises.first{$0.id == value}!)
                } else {
                    Text("Erro")
                }
            }
        }
        
    }
    
    private func deleteExercises(at offsets: IndexSet, musculo: Musculo) {
        withAnimation {
            for index in offsets {
                modelContext.delete(exercises.filter{$0.musculo == musculo}[index])
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
