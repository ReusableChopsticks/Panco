//
//  PancoApp.swiftw//  Panco
//
//  Created by Erick Hadi on 13/7/2025.
//

import SwiftUI

@main
struct PancoApp: App {
    @State var recipeManager = RecipeManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(recipeManager)
//            RecipeView()
        }
    }
}
