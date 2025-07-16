//
//  RootPlanView.swift
//  Panco
//
//  Created by Erick Hadi on 16/7/2025.
//

import SwiftUI

struct RootPlanView: View {
    @Environment(RecipeManager.self) var recipeManager: RecipeManager
    @State private var isActive : Bool = false
    
    var body: some View {
        NavigationStack {
            if !recipeManager.notEmpty {
                EmptyPlanView(rootIsActive: $isActive)
            } else {
                FilledPlanView(rootIsActive: $isActive)
            }
        }
    }
}

#Preview {
    RootPlanView()
        .environment(RecipeManager())
}
