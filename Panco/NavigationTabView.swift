//
//  NavigationTabView.swift
//  Panco
//
//  Created by Erick Hadi on 14/7/2025.
//

import SwiftUI

struct NavigationTabView: View {
    @Environment(RecipeManager.self) var recipeManager: RecipeManager
    
    var body: some View {
        TabView {
            Tab("Plan", systemImage: "text.document") {
                EmptyPlanView().environment(recipeManager)
            }
            Tab("Favourites", systemImage: "heart") {
                FavouritesView().environment(recipeManager)
            }
            
            Tab("History", systemImage: "clock") {
                ProfileHistoryView().environment(recipeManager)
            }
            
            Tab("Preferences", systemImage: "person.fill") {
                FavouritesView().environment(recipeManager)
            }
        }
    }
}



#Preview {
    NavigationTabView()
}
