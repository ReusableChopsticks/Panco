//
//  RecipeManager.swift
//  Panco
//
//  Created by Erick Hadi on 14/7/2025.
//

import Observation
import Foundation
import SwiftUI


@Observable class RecipeManager {
    var recipes = [RecipesResult]()
    var mealPlan: [PortionModel] = []
    var history: [MealPlanHistoryModel] = []
    
    var allergies: [String] = []
    var dislikes: [String] = []
    var diet: [String] = []
 
    func printDebug() {
        print("DEBUG: \(recipes)")
    }
    
//    called in PlanningRecipeView
    func loadData(maxDuration: Int) async {
        guard var urlComponents = URLComponents(string: "https://api.spoonacular.com/recipes/complexSearch") else {
            print("Invalid URL")
            return
        }
        
        var queryItems: [URLQueryItem] = []
        queryItems.append(URLQueryItem(name: "apiKey", value: "fca410445057430d98b609cbd5370dbf"))
        queryItems.append(URLQueryItem(name: "maxReadyTime", value: "\(maxDuration)"))

        if !allergies.isEmpty {
            queryItems.append(URLQueryItem(name: "intolerances", value: allergies.joined(separator: ",")))
        }
        if !dislikes.isEmpty {
            queryItems.append(URLQueryItem(name: "excludeIngredients", value: dislikes.joined(separator: ",")))
        }
        if !diet.isEmpty {
            queryItems.append(URLQueryItem(name: "diet", value: diet.joined(separator: ",")))
        }
        
        urlComponents.queryItems = queryItems
        
        guard let finalURL = urlComponents.url else {
            print("Failed to construct URL")
            return
        }
        
        print("Fetching recipes: \(finalURL)")
        
        do {
            let (data, _) = try await URLSession.shared.data(from: finalURL)
            let decodedResponse = try JSONDecoder().decode(RecipesResponse.self, from: data)
            
            // ✅ Update the published recipes array
            recipes = decodedResponse.results
            
            print("✅ Loaded \(recipes.count) recipes")
        } catch {
            print("❌ Error fetching data: \(error.localizedDescription)")
            recipes = [] // clear recipes on failure
        }
    }

    
    func saveCurrentMealPlanToHistory() {
        let newHistoryEntry = MealPlanHistoryModel(history: mealPlan)
        history.append(newHistoryEntry)
    }
    
    func debugLog() {
        print(mealPlan)
    }
}

struct MealPlanHistoryModel: Identifiable {
    var id = UUID()
    var date: Date = Date()
    var history: [PortionModel]
}

struct PortionModel: Identifiable {
    var id: Int { recipe.id }
    var recipe: RecipesResult
    var portion: Int
}

struct RecipesResponse: Codable {
    var results: [RecipesResult]
}

struct RecipesResult: Codable {
    var id: Int
    var title: String
    var image: String
    var imageType: String
}
