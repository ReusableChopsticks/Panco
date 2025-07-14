//
//  ContentView.swift
//  Panco
//
//  Created by Erick Hadi on 13/7/2025.
//

import SwiftUI

struct ContentView: View {
    @Environment(RecipeManager.self) var recipeManager: RecipeManager

    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
                NavigationLink("Get Recipes") {
                    RecipeView()
                }
                Divider()
                Text("Recipes count: \(recipeManager.recipes.count)")
                
                List {
                    
                }
            }
            .padding()
        }
    }
        
}

#Preview {
    ContentView()
}
