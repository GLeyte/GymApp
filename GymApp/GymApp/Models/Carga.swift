//
//  Carga.swift
//  GymApp
//
//  Created by Gabriel Leite on 02/11/23.
//

import Foundation
import SwiftData

@Model
final class Carga: Codable {
    
    enum CodingKeys: CodingKey {
        case peso, date
    }
    
    var peso: Float
    var date: Date
    
    init(peso: Float, date: Date) {
        self.peso = peso
        self.date = date
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.peso = try container.decode(Float.self, forKey: .peso)
        self.date = try container.decode(Date.self, forKey: .date)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(peso, forKey: .peso)
        try container.encode(date, forKey: .date)
    }
}
