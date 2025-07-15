//
//  RootPlanView.swift
//  Panco
//
//  Created by Erick Hadi on 16/7/2025.
//

import SwiftUI

struct RootPlanView: View {
    @Environment(RecipeManager.self) var recipeManager: RecipeManager
    
    var body: some View {
        if recipeManager.history.isEmpty {
            EmptyPlanView()
        } else {
//            FilledPlanView()
        }
    }
}

#Preview {
    RootPlanView().environment(RecipeManager())
}
