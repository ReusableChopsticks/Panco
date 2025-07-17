//
//  NavigationTabView.swift
//  Panco
//
//  Created by Erick Hadi on 14/7/2025.
//

import SwiftUI

struct NavigationTabView: View {
    @Environment(RecipeManager.self) var recipeManager: RecipeManager
    @State private var isOnboarding = true
    
    
    
    var body: some View {
        if isOnboarding {
            OnboardingRootView(isOnboarding: $isOnboarding)
//            Button("Finish onboarding") {
//                isOnboarding = false
//            }
        } else {
            TabView {
                Tab("Plan", systemImage: "text.document") {
                    RootPlanView().environment(recipeManager)
                }
                Tab("Favourites", systemImage: "heart") {
                    FavouritesView().environment(recipeManager)
                }
                
                Tab("History", systemImage: "clock") {
                    ProfileHistoryView().environment(recipeManager)
                }
                
                Tab("Preferences", systemImage: "person.fill") {
                    PreferencesView().environment(recipeManager)
                }
            }
        }
        
    }
}



#Preview {
    NavigationTabView().environment(RecipeManager())
}
