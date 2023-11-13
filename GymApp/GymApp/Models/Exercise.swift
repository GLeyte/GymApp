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
        case nome, musculo, carga, ultimaCarga, series, descricao
    }
    
    @Attribute(.unique) var id: String = UUID().uuidString
    var nome: String
    var musculo: Musculo
    var carga : [Carga]? = []
    var ultimaCarga: Float
    var series: Int
    var descricao: String
    
    init(nome: String, musculo: Musculo, carga: [Carga], ultimaCarga: Float, series: Int, descricao: String) {
        
        self.nome = nome
        self.musculo = musculo
        self.ultimaCarga = ultimaCarga
        self.carga = carga
        self.series = series
        self.descricao = descricao
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.nome = try container.decode(String.self, forKey: .nome)
        self.musculo = try container.decode(Musculo.self, forKey: .musculo)
        self.carga = try container.decode([Carga].self, forKey: .carga)
        self.ultimaCarga = try container.decode(Float.self, forKey: .ultimaCarga)
        self.series = try container.decode(Int.self, forKey: .series)
        self.descricao = try container.decode(String.self, forKey: .descricao)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(nome, forKey: .nome)
        try container.encode(musculo, forKey: .musculo)
        try container.encode(carga, forKey: .carga)
        try container.encode(ultimaCarga, forKey: .carga)
        try container.encode(series, forKey: .series)
        try container.encode(descricao, forKey: .descricao)
    }
    
    static let example = Exercise(nome: "Extensora", musculo: .pernas, carga: [Carga(peso: 40, date: Date(timeIntervalSinceNow: -1000000)), Carga(peso: 52, date: .now)], ultimaCarga: 52, series: 4, descricao: "8")
    
}
