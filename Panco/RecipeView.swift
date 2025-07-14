//
//  RecipeView.swift
//  Panco
//
//  Created by Erick Hadi on 14/7/2025.
//

import SwiftUI

struct RecipeView: View {
    @Environment(RecipeManager.self) var recipeManager: RecipeManager
    
    
    
//    duuh
    @State private var results = [RecipesResult]()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        
        Button("Sup") {
            Task {
                await recipeManager.loadData(100)
            }
        }
    }
    
    
}


#Preview {
    RecipeView().environment(RecipeManager())
}
