//
//  NavigationTabView.swift
//  Panco
//
//  Created by Erick Hadi on 14/7/2025.
//

import SwiftUI

struct NavigationTabView: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
    var body: some View {
        TabView {
            Tab("Plan", systemImage: "text.document") {
                EmptyPlanView()
            }
//            }.badge("!")
            Tab("Favourites", systemImage: "heart") {
                FavouritesView()
            }
            
            Tab("History", systemImage: "clock") {
                FavouritesView()
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
