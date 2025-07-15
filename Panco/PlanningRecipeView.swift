
// PlanningRecipeView: For users to select recipes for the week
// Created by: Jannalyn Tan on 14 July
// Last edited by: Nikki on 14 July 9.30PM (Sent)

import SwiftUI

struct PlanningRecipeView: View {
    @Environment(RecipeManager.self) var recipeManager: RecipeManager
    
    @Binding var rootIsActive: Bool
    
    @State var selectedRecipes: Set<RecipesResult> = []
    
    var body: some View {
        ZStack {
            Color(.pancoNeutral)
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                // Load recipes manually for now
                Button("Load Recipes") {
                    Task {
                        await recipeManager.loadData(maxDuration: 30)
                    }
                }
                
                HeaderView(title: "Recipe", progress: 0.66)
                
                SurpriseButtonsView(
                    recipes: recipeManager.recipes,
                    selectedRecipes: $selectedRecipes
                )
                
                RecipeGridView(
                    recipes: recipeManager.recipes,
                    selectedRecipes: $selectedRecipes
                )
            }
            
            ContinueButtonView(
                selectedRecipes: selectedRecipes,
                rootIsActive: $rootIsActive
            )
        }
    }
}



struct HeaderView: View {
    let title: String
    let progress: Double
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Spacer()
                ProgressView(value: progress)
                    .progressViewStyle(LinearProgressViewStyle(tint: Color.pancoGreen))
                    .scaleEffect(x: 1, y: 2, anchor: .center) // make progress bar taller
                    .frame(width: 160)
                    .padding(.top)
                Spacer()
            }
            
            HStack {
                Text(title)
                    .fontWeight(.bold)
                    .font(.largeTitle)
                Spacer()
            }
            .padding(.horizontal, 20)
        }
    }
}



struct SurpriseButtonsView: View {
    var recipes: [RecipesResult]
    @Binding var selectedRecipes: Set<RecipesResult>
    
    var body: some View {
        HStack {
            Button("Surprise Me") {
                selectedRecipes.removeAll()
                
                let numberToSelect = min(3, recipes.count)
                selectedRecipes = Set(recipes.shuffled().prefix(numberToSelect))
            }
            .foregroundColor(Color.pancoNeutral)
            .font(.headline.bold())
            .frame(width: 260, height: 70)
            .background(Color.pancoGreen)
            .cornerRadius(20)
            .shadow(radius: 2)
            
            Button {
                // Maybe shuffle all recipes in grid
            } label: {
                Image(systemName: "shuffle")
                    .font(.title2)
                    .foregroundColor(.pancoNeutral)
            }
            .frame(width: 90, height: 70)
            .background(Color.pancoGreen)
            .cornerRadius(20)
            .shadow(radius: 2)
        }
        .padding(.top, 10)
    }
}



struct RecipeGridView: View {
    let recipes: [RecipesResult]
    @Binding var selectedRecipes: Set<RecipesResult>
    
    private let columns = [
        GridItem(.fixed(150), spacing: 40),
        GridItem(.fixed(150), spacing: 40)
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 2) {
                ForEach(recipes, id: \.id) { recipe in
                    RecipeCard(
                        recipe: recipe,
                        isSelected: selectedRecipes.contains(recipe)
                    ) {
                        toggleSelection(for: recipe)
                    }
                }
                FavouriteCard()
            }
            .padding(.horizontal)
        }
    }
    
    private func toggleSelection(for recipe: RecipesResult) {
        if selectedRecipes.contains(recipe) {
            selectedRecipes.remove(recipe)
        } else {
            selectedRecipes.insert(recipe)
        }
    }
}



struct RecipeCard: View {
    let recipe: RecipesResult
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            
            
            AsyncImage(url: URL(string: recipe.image)) { img in
                img.resizable()
            } placeholder: {
                Color.gray.opacity(0.3)
            }
            .frame(width: 170, height: 170)
            .cornerRadius(20)
            
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.black.opacity(0.4))
                .frame(width: 170, height: 170)
            
            // Title
            Text(recipe.title)
                .font(.title3.bold())
                .foregroundColor(.white)
                .padding(10)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
            
            // Selection overlay
            if isSelected {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 26))
                    .foregroundColor(.pancoNeutral)
                    .offset(x: -10, y: 10)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.pancoRed, lineWidth: 5)
                    .frame(width: 170, height: 170)
            }
        }
        .frame(width: 170, height: 170)
        .padding(10)
        .onTapGesture { onTap() }
    }
}

struct FavouriteCard: View {
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.black.opacity(0.8))
                .frame(width: 170, height: 170)
            
            Image(systemName: "plus")
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(.pancoNeutral)
                .background(
                    Circle()
                        .fill(Color.pancoGreen)
                        .frame(width: 50, height: 50)
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            
            Text("Favourites")
                .font(.title3.bold())
                .foregroundColor(.white)
                .padding(10)
        }
        .frame(width: 170, height: 170)
        .padding(10)
    }
}

struct ContinueButtonView: View {
    let selectedRecipes: Set<RecipesResult>
    @Environment(RecipeManager.self) var recipeManager
    @Binding var rootIsActive: Bool
    
    var body: some View {
        VStack {
            Spacer()
            
            if selectedRecipes.count > 0 {
                NavigationLink {
                    // ✅ Before navigating, update mealPlan
                    let mealPlan = selectedRecipes.map { PortionModel(recipe: $0, portion: 1) }
                    recipeManager.mealPlan = mealPlan
                    
                    return PlanningPortionView(recipeCount: selectedRecipes.count,
                                               rootIsActive: $rootIsActive)
                    
                } label: {
                    Text("Continue")
                        .foregroundColor(.pancoNeutral)
                        .font(.headline)
                        .padding()
                        .frame(width: 180, height: 60)
                        .background(Color.pancoLightGreen)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(radius: 5)
                }
            }
        }
    }
}




#Preview {
    PlanningRecipeView(rootIsActive: .constant(false)).environment(RecipeManager())
}
