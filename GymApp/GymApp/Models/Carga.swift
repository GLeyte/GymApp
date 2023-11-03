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
