//
//  NavigationTabView.swift
//  Panco
//
//  Created by Erick Hadi on 14/7/2025.
//

import SwiftUI

struct NavigationTabView: View {
    var body: some View {
        TabView {
            Tab("Plan", systemImage: "text.document") {
                EmptyPlanView()
            }
            Tab("Favourites", systemImage: "heart") {
                FavouritesView()
            }
            
            Tab("History", systemImage: "clock") {
                ProfileHistoryView()
            }
            
            Tab("Preferences", systemImage: "person.fill") {
                FavouritesView()
            }
        }
    }
}



#Preview {
    NavigationTabView()
}
