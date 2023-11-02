//
//  Exercise.swift
//  GymApp
//
//  Created by Gabriel Leite on 02/11/23.
//

import Foundation
import SwiftData

@Model
final class Exercise: Codable {
    
    enum CodingKeys: CodingKey {
        case nome, musculo, carga, series, repeticoes
    }
    
    @Attribute(.unique) var id: String = UUID().uuidString
    var nome: String
    var musculo: Musculo
    var carga : [Carga]? = []
    var series: Int
    var repeticoes: String
    
    init(nome: String, musculo: Musculo, carga: [Carga], series: Int, repeticoes: String) {
        
        self.nome = nome
        self.musculo = musculo
        self.carga = carga
        self.series = series
        self.repeticoes = repeticoes
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.nome = try container.decode(String.self, forKey: .nome)
        self.musculo = try container.decode(Musculo.self, forKey: .musculo)
        self.carga = try container.decode([Carga].self, forKey: .carga)
        self.series = try container.decode(Int.self, forKey: .series)
        self.repeticoes = try container.decode(String.self, forKey: .repeticoes)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(nome, forKey: .nome)
        try container.encode(musculo, forKey: .musculo)
        try container.encode(carga, forKey: .carga)
        try container.encode(series, forKey: .series)
        try container.encode(repeticoes, forKey: .repeticoes)
    }
    
}

@Model
final class Carga: Codable {
    
    enum CodingKeys: CodingKey {
        case peso, data
    }
    
    var peso: Float
    var data: Date
    
    init(peso: Float, data: Date) {
        self.peso = peso
        self.data = data
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.peso = try container.decode(Float.self, forKey: .peso)
        self.data = try container.decode(Date.self, forKey: .data)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(peso, forKey: .peso)
        try container.encode(data, forKey: .data)
    }
}

enum Musculo: String, Codable, Identifiable, CaseIterable{
    
    var id : String { UUID().uuidString }
    
    case costas = "Costas"
    case biceps = "Bíceps"
    case peito = "Peito"
    case ombro = "Ombro"
    case triceps = "Tríceps"
    case pernas = "Pernas"
    case abdomen = "Abdômen"
}
