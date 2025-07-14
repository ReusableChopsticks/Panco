//
//  RecipeManager.swift
//  Panco
//
//  Created by Erick Hadi on 14/7/2025.
//

import Foundation
import SwiftUI

@Observable
class RecipeManager {
    var recipes: [RecipesResult] = []
 
    func printDebug() {
        print("DEBUG: \(recipes)")
    }
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
