//
//  NewExerciseViewModel.swift
//  GymApp
//
//  Created by Gabriel Leite on 03/11/23.
//

import Foundation

class NewExerciseViewModel {
    
    var nome: String
    var musculo: Musculo
    var peso: Float
    var series: Int
    var descricao: String
    
    init(nome: String, musculo: Musculo, peso: Float, series: Int, descricao: String) {
        self.nome = nome
        self.musculo = musculo
        self.peso = peso
        self.series = series
        self.descricao = descricao
    }
    
}
