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
                        NavigationLink(value: exercises.firstIndex(of:exercise)) {
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
                ExerciseStatusView(exercise: exercises[value])
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
