//
//  PathType.swift
//  GymApp
//
//  Created by Gabriel Leite on 02/11/23.
//

import Foundation

class PathType: ObservableObject {
    @Published var path: [String]
    init(){
        self.path = []
    }
}
