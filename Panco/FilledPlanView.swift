// FilledPlanView: Display user's current meal plan.
// Created by: Nikki on 14 July
// Last edited by: Nikki on 14 July 9.30PM (Sent)
// ‼️ P.S this view should override the EmptyPlanView


import SwiftUI

// MARK: - Helpers

/// Formats 1.0 → “1”, 200.0 → “200”
private extension Double {
    var clean: String {
        truncatingRemainder(dividingBy: 1) == 0
        ? String(format: "%.0f", self)
        : String(self)
    }
}

/// Makes `String` usable with `.popover(item:)`
extension String: @retroactive Identifiable { public var id: String { self } }

// MARK: - Data model for the pop‑over list

struct Ingredient: Identifiable {
    let id = UUID()
    let name: String
    let amount: Double
    let unit: String
}

// MARK: - Main View

struct FilledPlanView: View {
    // Inputs you’ll later fetch from other screens
    var selectedRecipes: [String] = ["Chicken Rice", "R2", "R3", "R4", "R5"]
    let groceryList:   String     // placeholder
    let chosenRecipes: String     // placeholder
    
    // Grid layout
    private let columns = [
        GridItem(.fixed(150), spacing: 40),
        GridItem(.fixed(150), spacing: 40)
    ]
    
    // Which card is tapped (nil → no pop‑over)
    @State private var selectedRecipeName: String?
    
    // Sample ingredients (use real data per recipe later)
    private let sampleIngredients: [Ingredient] = [
        .init(name: "Chicken",   amount: 200, unit: "g"),
        .init(name: "Rice",      amount: 1,   unit: "cup"),
        .init(name: "Onion",     amount: 1,   unit: "unit"),
        .init(name: "Coriander", amount: 50,  unit: "g"),
        .init(name: "Cucumber",  amount: 1,   unit: "unit"),
        .init(name: "Soy Sauce", amount: 1,   unit: "tbsp")
    ]
    
    var body: some View {
        ZStack {
            Color(.pancoNeutral).ignoresSafeArea()
            
            VStack {
                header
                ScrollView {
                    groceryListTab
                    recipeGrid
                }
                newPlanButton
            }
        }
        // ONE pop‑over attached to the whole screen
        .popover(item: $selectedRecipeName) { _ in
            ingredientsPopover
        }
    }
}

// MARK: - Sub‑views

private extension FilledPlanView {
    // Top “Plan” title + pencil
    var header: some View {
        
        // ⭐️ Page title items
        HStack {
            Text("Plans")
                .fontWeight(.bold)
                .font(.largeTitle)
                .padding(.trailing, 200)
            
            NavigationLink {
                PlanningRecipeView()                 // ← destination view
            } label: {
                Image(systemName: "pencil")          // ← pencil icon
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
                    .foregroundStyle(.pancoRed)
            }
            .buttonStyle(.plain)                     // (optional) removes default blue tint
        }
        .padding(.top, 50)
    }
    
    // ⭐️ Red grocery‑list pill
    var groceryListTab: some View {
        ZStack {
            NavigationLink(destination: PlanningConstraintsView()) { //‼️ REPLACE "PlanningConstraintsView" with "PlanningGroceryView"
                Text("  Grocery List")
                    .foregroundColor(.pancoNeutral)
                    .font(.title)
                    .fontWeight(.semibold)
                    .frame(width: 350, height: 45, alignment: .leading)
                    .background(.pancoLightRed)
                    .cornerRadius(30)
                    .shadow(radius: 5)
                    .padding(.top, 20)
            }
            
            Image(systemName: "chevron.compact.forward")
                .resizable()
                .frame(width:15, height: 20)
                .foregroundStyle(.pancoNeutral)
                .padding(.leading, 250)
                .padding(.top, 20)
            
            // ‼️ SHOW exclamation mark only if grocery list isn’t empty (try IF statements?)
            Image(systemName: "exclamationmark.circle.fill")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundStyle(.pancoRed)
                .padding(.leading, 300)
                .padding(.top, -30)
        }
    }
    
    // ⭐️ Two‑column grid of tappable recipe cards
    var recipeGrid: some View {
        LazyVGrid(columns: columns, spacing: 4) {
            ForEach(selectedRecipes, id: \.self) { name in
                Button {
                    selectedRecipeName = name       // triggers pop‑over
                } label: {
                    ZStack(alignment: .bottomLeading) {
                        // Placeholder (replace with Image(name) when ready)
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 170, height: 170)
                            .padding(10)
                        
                        Text(name)
                            .font(.title3)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding(6)
                            .padding(.leading, 15)
                            .padding(.bottom, 10)
                    }
                }
                .buttonStyle(.plain)
            }
        }
    }
    
    // ⭐️ Bottom “New Plan” button
    var newPlanButton: some View {
        NavigationLink {
            PlanningConstraintsView()          // ← destination screen
        } label: {
            Text("New Plan")                   // ← label that looks like a button
                .foregroundColor(.pancoNeutral)
                .font(.headline)
                .padding()
                .frame(width: 180, height: 60)
                .background(.pancoRed)
                .cornerRadius(20)
                .shadow(radius: 5)
        }
        .padding(.top, 20)                     // outer spacing
    }
    
    // Body of the pop‑over
    var ingredientsPopover: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Optional header: Text(selectedRecipeName ?? "").font(.headline)
            
            ForEach(sampleIngredients) { item in
                Text("\(item.name): \(item.amount.clean) \(item.unit)")
            }
            
            Divider()
            
            Button("Close") { selectedRecipeName = nil }
                .padding(.top, 8)
        }
        .padding()
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        FilledPlanView(groceryList: "", chosenRecipes: "")
    }
}
