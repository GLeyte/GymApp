//
//  ExerciseStatusView.swift
//  GymApp
//
//  Created by Gabriel Leite on 03/11/23.
//

import SwiftUI
import SwiftData
import Charts

struct ExerciseStatusView: View {
    
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var stackPath: PathType
    @Query(sort: \Exercise.nome) private var exercises: [Exercise]
    
    @State var editionMode: Bool = false
    @State var exercise: Exercise
    @State var editOn = false
    @FocusState private var nomeFocused: Bool
    @FocusState private var descricaoFocused: Bool
    let dateFormatter = DateFormatter()
    
    var body: some View {
        List {
            
            Section {
                
                if !editOn {
                    normalMode
                } else {
                    editMode
                }
                
            }
            
            if let historico = exercise.carga?.sorted {$0.date > $1.date} {
                
                Section {
                    VStack {
                        GroupBox ( "Histórico de carga") {
                            Chart(historico) {
                                
                                if historico.count > 1 {
                                    LineMark(
                                        x: .value("Data", ($0.date.formatted(.dateTime.day(.twoDigits).month(.twoDigits)))),
                                        y: .value("Carga", $0.peso)
                                    )
                                } else {
                                    PointMark(
                                        x: .value("Data", ($0.date.formatted(.dateTime.day(.twoDigits).month(.twoDigits)))),
                                        y: .value("Carga", $0.peso)
                                    )
                                }
                            }
                        }
                        .groupBoxStyle(YellowGroupBoxStyle())
                    }
                }
                
                Section {
                    
                    ForEach(historico, id:\.self) {value in
                        
                        HStack(spacing: 16) {
                            
//                            Text(dateFormatter.string(from: value.date))
                            Text("\(value.date.formatted(date: .long, time: .omitted))")
                            Spacer()
                            Text("\(value.peso, specifier: "%.1f")")
                        }
                        .onAppear{
                            dateFormatter.dateStyle = .medium
                            dateFormatter.timeStyle = .none
                            dateFormatter.locale = Locale(identifier: "pt_BR")
//                            print(dateFormatter.string(from: value.date))
                        }
                        
                    }
                } header: {
                    Text("Histórico de carga")
                }
            }
            
        }
        .toolbar {
            if !editOn {
                Button {
                    editOn = true
                } label: {
                    Text("Edit")
                }
            } else {
                Button {
                    editOn = false
                    if exercise.ultimaCarga != exercise.carga?.last!.peso {
                        exercise.carga?.append(Carga(peso: exercise.ultimaCarga, date: .now))
                    }
                    try? modelContext.save()
                } label: {
                    Text("Salvar")
                }
            }
        }
        .navigationBarTitle(exercise.musculo.localizedName, displayMode: .inline)
    }
}

extension ExerciseStatusView {
    
    var normalMode: some View {
        
        Group {
            
            HStack(spacing: 16) {
                Text("Nome do exercício:")
                Spacer()
                Text(exercise.nome)
            }
            
            HStack(spacing: 16) {
                Text("Músculo focal:")
                Spacer()
                Text(exercise.musculo.localizedName)
            }
            
            HStack(spacing: 16) {
                Text("Carga:")
                Spacer()
                Text(String(exercise.ultimaCarga))
            }
            
            HStack(spacing: 16) {
                Text("Número de séries:")
                Spacer()
                Text(String(exercise.series))
            }
            
            HStack(spacing: 16) {
                Text("Descrição:")
                Spacer()
                Text(exercise.descricao)
            }
        }
    }
    
    var editMode: some View {
        
        Group {
            HStack(spacing: 16) {
                Text("Nome do exercício:")
                TextField("", text: $exercise.nome)
                    .multilineTextAlignment(.trailing)
                    .foregroundStyle(.secondary)
                // Gambiarra
                    .focused($nomeFocused)
                    .onLongPressGesture(minimumDuration: 0.0) {
                        nomeFocused = true
                    }
                    .autocorrectionDisabled()
            }
            
            Picker("Músculo focal:", selection: $exercise.musculo) {
                ForEach(Musculo.allCases , id: \.id){
                    Text($0.localizedName)
                        .tag($0)
                }
            }
            
            HStack(spacing: 16) {
                Text("Carga:")
                TextField("", value: $exercise.ultimaCarga, format: .number)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numbersAndPunctuation)
                    .foregroundStyle(.secondary)
            }
            
            Picker("Número de séries:", selection: $exercise.series) {
                ForEach(3..<6){
                    Text("\($0)")
                        .tag($0)
                }
            }
            
            HStack(spacing: 16) {
                Text("Descrição:")
                
                TextField("", text: $exercise.descricao)
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
    
}

struct YellowGroupBoxStyle: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.content
            .padding(.top, 30)
            .padding(20)
            .cornerRadius(20)
            .overlay(
                configuration.label.padding(10),
                alignment: .topLeading
            )
    }
}
