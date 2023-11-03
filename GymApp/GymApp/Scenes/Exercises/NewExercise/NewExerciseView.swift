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
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    NewExerciseView()
}
