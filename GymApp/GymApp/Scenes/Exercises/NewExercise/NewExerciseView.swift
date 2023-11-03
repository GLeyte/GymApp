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
    
    @State private var model = NewExerciseViewModel(nome: "", musculo: .abdomen, peso: 0.0, series: 4, repeticoes: "")
    
    @FocusState private var nomeFocused: Bool
    @FocusState private var repeticoesFocused: Bool
    
    var body: some View {
        
        VStack {
            
            List {
                
                Section {
                    
                    HStack(spacing: 16) {
                        Text("Nome do exercício:")
                        TextField("", text: $model.nome)
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
                        Text("Repetições:")
                        
                        TextField("", text: $model.repeticoes)
                            .foregroundStyle(.secondary)
                        // Gambiarra
                            .focused($repeticoesFocused)
                            .onLongPressGesture(minimumDuration: 0.0) {
                                repeticoesFocused = true
                            }
                            .autocorrectionDisabled()
                    }
                }
                
                Section(footer: HStack(alignment: .center) {
                    Spacer()
                    botao
                    Spacer()
                }) {
                    EmptyView()
                }
            }
            .scrollDisabled(true)
            
        }
        .navigationBarTitle("Acidionar exercício", displayMode: .inline)
    }
}

extension NewExerciseView {
    
    
    var botao: some View {
        Button {
            addExercises()
            stackPath.path.removeLast()
        } label: {
            
            ZStack {
                Text("Acidionar exercício")
                    .padding()
                    .background(Color.accentColor)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
        }
    }
    
    private func addExercises() {
        withAnimation {
            
            let newItem = Exercise(nome: model.nome, musculo: model.musculo, carga: [Carga(peso: model.peso, data: .now)], ultimaCarga: model.peso, series: model.series, repeticoes: model.repeticoes)
            modelContext.insert(newItem)
        }
    }
    
}

#Preview {
    NewExerciseView()
}
