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
    
    @State private var nome: String = ""
    @State private var musculo: Musculo = .abdomen
    @State private var peso: Float = 0.0
    @State private var series = 3
    @State private var repeticoes = ""
    @FocusState private var nomeFocused: Bool
    @FocusState private var repeticoesFocused: Bool
    
    var body: some View {
        
        VStack {
            
            List {
                
                Section {
                    
                    HStack(spacing: 16) {
                        Text("Nome do exercício:")
                        TextField("", text: $nome)
                            .foregroundStyle(.secondary)
                        // Gambiarra
                            .focused($nomeFocused)
                            .onLongPressGesture(minimumDuration: 0.0) {
                                nomeFocused = true
                            }
                            .autocorrectionDisabled()
                    }
                    
                    Picker("Músculo focal:", selection: $musculo) {
                        ForEach(Musculo.allCases , id: \.id){
                            Text($0.localizedName)
                                .tag($0)
                        }
                    }
                    
                    HStack(spacing: 16) {
                        Text("Carga:")
                        
                        TextField("", value: $peso, format: .number)
                            .keyboardType(.decimalPad)
                            .foregroundStyle(.secondary)
                    }
                    
                    Picker("Número de séries:", selection: $series) {
                        ForEach(3..<6){
                            Text("\($0)")
                                .tag($0)
                        }
                    }
                    
                    HStack(spacing: 16) {
                        Text("Repetições:")
                        
                        TextField("", text: $repeticoes)
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
            let newItem = Exercise(nome: nome, musculo: musculo, carga: [Carga(peso: peso, data: .now)], ultimaCarga: peso, series: series, repeticoes: repeticoes)
            modelContext.insert(newItem)
        }
    }
    
}

#Preview {
    NewExerciseView()
}
