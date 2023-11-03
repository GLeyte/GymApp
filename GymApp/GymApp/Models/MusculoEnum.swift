//
//  MusculoEnum.swift
//  GymApp
//
//  Created by Gabriel Leite on 02/11/23.
//

import Foundation
import SwiftUI


enum Musculo: String, Codable, Identifiable, CaseIterable, Equatable{
    
    var id : String { UUID().uuidString }
    
    case abdomen = "Abdômen"
    case biceps = "Bíceps"
    case costas = "Costas"
    case peito = "Peito"
    case pernas = "Pernas"
    case ombro = "Ombro"
    case triceps = "Tríceps"
    
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
}
