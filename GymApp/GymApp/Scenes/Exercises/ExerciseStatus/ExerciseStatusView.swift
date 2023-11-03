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
    
    var body: some View {
        List {
            
            Section {
                
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
                    Text("Repetições:")
                    Spacer()
                    Text(exercise.repeticoes)
                }
                
            }
            
            Section {
                grafico
            }
            
            Section {
                ForEach([Carga(peso: 40, data: Date(timeIntervalSinceNow: -1000000)), Carga(peso: 52, data: .now)].reversed(), id:\.self) {value in
                    
                    HStack(spacing: 16) {
                        Text("\(value.data.formatted(date: .long, time: .omitted))")
                        Spacer()
                        Text("\(value.peso, specifier: "%.1f")")
                    }
                    
                }
            } header: {
                Text("Histórico de carga")
            }
            
        }
        .scrollDisabled(true)
    }
}

extension ExerciseStatusView {
    
    var grafico: some View {
        
        VStack {
            GroupBox ( "Histórico de carga") {
                Chart([Carga(peso: 40, data: Date(timeIntervalSinceNow: -1000000)), Carga(peso: 52, data: .now)]) {
                    LineMark(
                        x: .value("Data", ($0.data.formatted(.dateTime.day(.twoDigits).month(.twoDigits)))),
                        y: .value("Carga", $0.peso)
                    )
                }
            }
            .groupBoxStyle(YellowGroupBoxStyle())
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



#Preview {
    ExerciseStatusView(exercise: Exercise.example)
}
