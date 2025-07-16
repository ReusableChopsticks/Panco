import SwiftUI

// Row View for an Ingredient
struct IngredientRowView: View {
    @Binding var ingredient: Ingredient
    
    func formatSimpleDecimal(num: Double) -> String {
        if num >= 1 {
            return num.formatted()
        }
        else if num.isEqual(to: 0.5) {
            return "1/2"
        } else if num.isEqual(to: 0.25) {
            return "1/4"
        } else {
            return "unsupported decimal :("
        }
    }
    
    var body: some View {
        HStack(spacing: 15) {
            // Checkbox
            Image(systemName: ingredient.isChecked ? "checkmark.square.fill" : "square")
                .font(.title2)
                .foregroundColor(Color.pancoGreen)
                .onTapGesture {
                    ingredient.isChecked.toggle()
                }
            
            (
                Text("\(formatSimpleDecimal(num: ingredient.amount)) \(ingredient.unit)")
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.pancoGreen)
                + Text(" \(ingredient.name)")
                    .font(.body)
            )
            .padding(.vertical, 20)
            
            Spacer()
        }
        .padding(.vertical, 1)
        .padding(.horizontal, 20)
        .background(Color.pancoLightRed.opacity(0.15))
        .cornerRadius(15)
    }
}

// Section View for a recipe
struct RecipeIngredientsSection: View {
    let title: String
    @Binding var ingredients: [Ingredient]
    
    var body: some View {
        VStack {
            Text(title)
                .fontWeight(.bold)
                .font(.title2)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ForEach($ingredients) { $ingredient in
                IngredientRowView(ingredient: $ingredient)
            }
        }.padding(.horizontal, 6).padding(.bottom, 20)
    }
        
}

// Main Grocery View
struct PlanningGroceryView: View {
    @Environment(RecipeManager.self) var recipeManager: RecipeManager
    
    // Now using Ingredient model directly
    @State private var ingredients: [Ingredient] = [
        .init(name: "Chicken", amount: 200, unit: "grams"),
        .init(name: "Rice", amount: 1, unit: "cup"),
        .init(name: "Onion", amount: 1, unit: "unit"),
        .init(name: "Coriander", amount: 50, unit: "grams"),
        .init(name: "Cucumber", amount: 1, unit: "unit"),
        .init(name: "Soy Sauce", amount: 1, unit: "tbsp")
    ]
    
    @State private var fishTacoIngredients: [Ingredient] = [
        .init(name: "White Fish Fillets", amount: 500, unit: "grams"),
        .init(name: "Corn Tortillas", amount: 8, unit: "pieces"),
        .init(name: "Cabbage", amount: 2, unit: "cups"),
        .init(name: "Lime", amount: 2, unit: "units"),
        .init(name: "Sour Cream", amount: 0.5, unit: "cup"),
        .init(name: "Mayonnaise", amount: 0.25, unit: "cup"),
        .init(name: "Garlic", amount: 2, unit: "cloves"),
        .init(name: "Chili Powder", amount: 1, unit: "tsp"),
        .init(name: "Cumin", amount: 1, unit: "tsp"),
        .init(name: "Olive Oil", amount: 2, unit: "tbsp"),
        .init(name: "Fresh Cilantro", amount: 0.25, unit: "cup"),
        .init(name: "Salt", amount: 0.5, unit: "tsp"),
        .init(name: "Black Pepper", amount: 0.25, unit: "tsp")
    ]

    
    @Binding var rootIsActive: Bool
    
    var body: some View {
        ZStack {
            Color.pancoNeutral.ignoresSafeArea()
            
            VStack {
                // Header
                Text("Grocery List")
                    .fontWeight(.bold)
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                    .padding(.top, 20)
                
                ScrollView {
                    VStack(spacing: 12) {
                        RecipeIngredientsSection(
                            title: "Cheesy Chicken Casserole",
                            ingredients: $ingredients
                        )
                        
                        RecipeIngredientsSection(
                            title: "Fish Tacos",
                            ingredients: $fishTacoIngredients
                        )
                    }
                    .padding(.horizontal)
                }
                
                // Done button
                Button {
                    rootIsActive = false
                    recipeManager.notEmpty = true
                } label: {
                    Text("Done")
                        .foregroundColor(Color.pancoNeutral)
                        .font(.headline)
                        .frame(width: 180, height: 60)
                        .background(Color.pancoGreen)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(radius: 5)
                }
                .padding(.bottom, 20)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    // Share functionality here
                }) {
                    Image(systemName: "square.and.arrow.up")
                }
            }
        }
    }
}



// Preview
#Preview {
    NavigationView {
        PlanningGroceryView(rootIsActive: .constant(true))
            .environment(RecipeManager())
    }
}
