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
    private let API_KEY = "5808fdadcfa04697abafb3f0dea869eb"
    
    static var sampleRecipes: [RecipesResult] = [
        Panco.RecipesResult(id: 715421, title: "Cheesy Chicken Casserole", image: "https://www.jocooks.com/wp-content/uploads/2018/12/chicken-broccoli-rice-casserole-1-10-500x500.jpg", imageType: "jpg"),
        Panco.RecipesResult(id: 782601, title: "Fish Tacos", image: "https://www.seriouseats.com/thmb/y3Qf-ciu-nzLgYeJzK4xWoabibQ=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/SEA-M7011302_crunchy_fish_tacos6556-JenCausey-f8285ed3d8674b25bf16d027034fc41b.jpg", imageType: "jpg"),
        Panco.RecipesResult(id: 716406, title: "Asparagus and Pea Soup: Real Convenience Food", image: "https://img.spoonacular.com/recipes/716406-312x231.jpg", imageType: "jpg"),
        Panco.RecipesResult(id: 644387, title: "Garlicky Kale", image: "https://img.spoonacular.com/recipes/644387-312x231.jpg", imageType: "jpg"),
        Panco.RecipesResult(id: 716426, title: "Cauliflower, Brown Rice, and Vegetable Fried Rice", image: "https://img.spoonacular.com/recipes/716426-312x231.jpg", imageType: "jpg")]
    
    var recipes: [RecipesResult] = sampleRecipes
    var mealPlan: [PortionModel] = PortionModel.sampleData
    var history: [MealPlanHistoryModel] = []
    
    var notEmpty: Bool = false
    
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
        queryItems.append(URLQueryItem(name: "apiKey", value: API_KEY))
        queryItems.append(URLQueryItem(name: "maxReadyTime", value: "\(maxDuration)"))
        queryItems.append(URLQueryItem(name: "type", value: "main_course"))
        queryItems.append(URLQueryItem(name: "offset", value: "10"))

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
//            by default we give everything a portion of 1 first
//            this gets displayed in PlanningPortionView
            mealPlan = decodedResponse.results.map { PortionModel(recipe: $0, portion: 1) }
            print(recipes)
            
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

@Observable
class PortionModel: Identifiable {
    var id: Int { recipe.id }
    var recipe: RecipesResult
    var portion: Int
    
    init(recipe: RecipesResult, portion: Int) {
        self.recipe = recipe
        self.portion = portion
    }
    
    func incrementPortion() {
        portion += 1
    }
    
    func decrementPortion() {
        portion -= 1
    }

    static var sampleData: [PortionModel] = [Panco.PortionModel(recipe: Panco.RecipesResult(id: 716406, title: "Asparagus and Pea Soup: Real Convenience Food", image: "https://img.spoonacular.com/recipes/716406-312x231.jpg", imageType: "jpg"), portion: 1), Panco.PortionModel(recipe: Panco.RecipesResult(id: 716426, title: "Cauliflower, Brown Rice, and Vegetable Fried Rice", image: "https://img.spoonacular.com/recipes/716426-312x231.jpg", imageType: "jpg"), portion: 1)]
}

struct RecipesResponse: Codable {
    var results: [RecipesResult]
}

struct RecipesResult: Codable, Hashable, Equatable {
    var id: Int
    var title: String
    var image: String
    var imageType: String

    static func == (lhs: RecipesResult, rhs: RecipesResult) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
