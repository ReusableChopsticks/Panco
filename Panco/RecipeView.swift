//
//  RecipeView.swift
//  Panco
//
//  Created by Erick Hadi on 14/7/2025.
//

import SwiftUI

struct RecipeView: View {
    @Environment(RecipeManager.self) var recipeManager: RecipeManager
    
    let apiKey = URLQueryItem(name: "apiKey", value: "fca410445057430d98b609cbd5370dbf")
    let query = URLQueryItem(name: "query", value: "pasta")
    let excludeIngredients = URLQueryItem(name: "excludeIngredients", value: "chicken,bacon")
    
//    duuh
    @State private var results = [RecipesResult]()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        
        Button("Sup") {
            Task {
                await loadData()
            }
        }
    }
    
    func loadData() async {
        guard var url = URL(string: "https://api.spoonacular.com/recipes/complexSearch") else {
            print("Invalid URL")
            return
        }
        
        url.append(queryItems: [apiKey, query, excludeIngredients])
        print("EPIC URL: \(url)\n")
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decodedResponse = try? JSONDecoder().decode(RecipesResponse.self, from: data) {
                results = decodedResponse.results
            }
            recipeManager.recipes = results
            recipeManager.printDebug()
//            print(results)
        } catch {
            print("Invalid data")
        }
    }
}


#Preview {
    RecipeView()
}
