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
    var recipes: [RecipesResult] = []
    var mealPlan: [PortionModel] = []
    var history: [MealPlanHistoryModel] = []
    
    var allergies: [String] = []
    var dislikes: [String] = []
    var diet: [String] = []
 
    func printDebug() {
        print("DEBUG: \(recipes)")
    }
    
////    called in PlanningConstraintsView
//    func loadData(maxDuration: Int) async {
//        guard var urlComponents = URL(string: "https://api.spoonacular.com/recipes/complexSearch") else {
//            print("Invalid URL")
//            return
//        }
//        
//        var queryItems: [URLQueryItem] = []
//
//        // Add API key
//        queryItems.append(URLQueryItem(name: "apiKey", value: "YOUR_API_KEY"))
//
//        // Add maxDuration
//        queryItems.append(URLQueryItem(name: "maxReadyTime", value: "\(maxDuration)"))
//
//        // Add allergies as intolerances
//        if !allergies.isEmpty {
//            let value = allergies.joined(separator: ",")
//            queryItems.append(URLQueryItem(name: "intolerances", value: value))
//        }
//
//        // Add dislikes as excluded ingredients
//        if !dislikes.isEmpty {
//            let value = dislikes.joined(separator: ",")
//            queryItems.append(URLQueryItem(name: "excludeIngredients", value: value))
//        }
//
//        // Add diet preferences
//        if !diet.isEmpty {
//            let value = diet.joined(separator: ",")
//            queryItems.append(URLQueryItem(name: "diet", value: value))
//        }
//
//        urlComponents.append(queryItems: queryItems)
//        
//        let finalURL = urlComponents.absoluteString
//        
//        do {
//            let (data, _) = try await URLSession.shared.data(from: finalURL)
//            
//            if let decodedResponse = try? JSONDecoder().decode(RecipesResponse.self, from: data) {
//                results = decodedResponse.results
//            }
//            recipeManager.recipes = results
//            recipeManager.printDebug()
////            print(results)
//        } catch {
//            print("Invalid data")
//        } 
//    }
}

struct MealPlanHistoryModel {
    var history: [PortionModel] = []
    var date: String = ""
}

struct PortionModel {
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
