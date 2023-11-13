//
//  NewExerciseView.swift
//  GymApp
//
//  Created by Gabriel Leite on 02/11/23.
//

import SwiftUI
import SwiftData

struct NewExerciseView: View {
    
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var stackPath: PathType
    @Query private var exercises: [Exercise]
    
    @State private var model = NewExerciseViewModel(nome: "", musculo: .abdomen, peso: 0.0, series: 4, descricao: "")
    
    @FocusState private var nomeFocused: Bool
    @FocusState private var descricaoFocused: Bool
    
    var body: some View {
        
        VStack {
            
            List {
                
                Section {
                    
                    HStack(spacing: 16) {
                        Text("Nome do exercício:")
                        TextField("", text: $model.nome)
                            .multilineTextAlignment(.trailing)
                            .foregroundStyle(.secondary)
                        // Gambiarra
                            .focused($nomeFocused)
                            .onLongPressGesture(minimumDuration: 0.0) {
                                nomeFocused = true
                            }
                            .autocorrectionDisabled()
                    }
                    
                    Picker("Músculo focal:", selection: $model.musculo) {
                        ForEach(Musculo.allCases , id: \.id){
                            Text($0.localizedName)
                                .tag($0)
                        }
                    }
                    
                    HStack(spacing: 16) {
                        Text("Carga:")
                        
                        TextField("", value: $model.peso, format: .number)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.decimalPad)
                            .foregroundStyle(.secondary)
                    }
                    
                    Picker("Número de séries:", selection: $model.series) {
                        ForEach(3..<6){
                            Text("\($0)")
                                .tag($0)
                        }
                    }
                    
                    HStack(spacing: 16) {
                        Text("Descrição:")
                        
                        TextField("", text: $model.descricao)
                            .multilineTextAlignment(.trailing)
                            .foregroundStyle(.secondary)
                        // Gambiarra
                            .focused($descricaoFocused)
                            .onLongPressGesture(minimumDuration: 0.0) {
                                descricaoFocused = true
                            }
                            .autocorrectionDisabled()
                    }
                }
                
            }
            .toolbar{
                Button {
                    addExercises()
                    stackPath.path.removeLast()
                } label: {
                    Text("Adicionar")
                }
            }
            .scrollDisabled(true)
            
        }
        .navigationBarTitle("Acidionar exercício", displayMode: .inline)
    }
}

extension NewExerciseView {
    
    private func addExercises() {
        withAnimation {
            
            let newItem = Exercise(nome: model.nome, musculo: model.musculo, carga: [Carga(peso: model.peso, date: .now)], ultimaCarga: model.peso, series: model.series, descricao: model.descricao)
            modelContext.insert(newItem)
        }
    }
    
}

#Preview {
    NewExerciseView()
}
